class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def vendors
    render json: Vendor.all.as_json
  end

  def vehicle_search
    quotation = Quotation.create(quotation_params)
    render json: quotation.search_vehicles
  end


  private

  def quotation_params
    params.require(:quotation).permit(
      Quotation.attribute_names
    )
  end
end
