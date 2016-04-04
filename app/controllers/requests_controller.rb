class RequestsController < ApplicationController

  def index
  end

  def create
    @offer_request = OfferRequest.new(request_params)
    @offer_response = @offer_request.get_offers
  end

  private

  def request_params
    params.require(:request).permit(:uid, :pub0, :page)
  end
end