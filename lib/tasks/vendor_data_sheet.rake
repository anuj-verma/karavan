namespace :vendor_data_sheet do
  desc "Sync vehicle data from vendor sheets"
  task :sync, [:file_path, :vendor] => :environment do |t, args|
    puts args[:file_path]
    spreadsheet = open_file(args[:file_path]) rescue (p "Invalid File path")
    vendor = args[:vendor]
    headers = get_headers(spreadsheet)
    sheet = spreadsheet.sheet(vendor)
    parse_sheet(sheet, headers, vendor)
  end
  
  def parse_sheet(sheet, headers, vendor_name)
    vendor = Vendor.find_by(short_name: /#{vendor_name}/i)
    (2..sheet.last_row).each do |index|
      record = Hash[
        [
          headers,
          sheet.row(index)[0..headers.length - 1]
        ].transpose
      ]
      vehicle = vendor.vehicles.find_or_create_by!(
        registration_number: record["registration_number"]
      )
      vehicle.attributes = {
        make: record["make"].upcase,
        model: record["model"].upcase,
        submodel: record["submodel"].upcase,
        seating_capacity: record["seating_capacity"].to_i,
        vehicle_type: record["vehicle_type"].upcase,
        origin_city: record["from"].upcase,
      }
      vehicle.vehicle_details.find_or_create_by!(
        from: record["from"].upcase,
        to: record["to"].upcase,
        estimated_distance: record["estimated_distance"].to_i,
        price_per_km: record["price_per_km"].to_f,
        penalty_per_km: record["penalty_per_km"].to_f,
        price_per_day: record["price_per_day"].to_i,
        km_cap_per_day: record["km_cap_per_day"].to_i,
        penalty_per_day: record["penalty_per_day"].to_i,
        package_type: record["package_type"].upcase
      )
      vehicle.save
    end
  end

  def get_headers(spreadsheet)
    spreadsheet.row(1).reject(&:blank?).reduce([]){
      |arr, attribute| arr << attribute.try(:gsub, /\s+/, '_').try(:underscore)
    }
  end
  
  def get_file_type(file_path)
    /\.(?<extension>[a-z]+)/i =~ file_path
    extension
  end

  def get_file_name(file_path)
    /\/.*\/(?<file_name>.*)\./i =~ file_path
    file_name
  end

  def open_file(file_path)
    Roo::Spreadsheet.open(file_path, extension: get_file_type(file_path))
  end
end
