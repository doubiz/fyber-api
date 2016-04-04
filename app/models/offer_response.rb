class OfferResponse
  include ActiveModel::Model
  attr_accessor :offers, :information, :pages, :count, :code, :message, :store_id

  def initialize(signature, json_response)
    if verify_response(signature, json_response)
      parsed_response = JSON.parse(json_response)
      super(parsed_response)
      parse_offers(parsed_response["offers"])
    else
      raise "Response has been tampered"
    end
  end

  private
  def parse_offers(offers)
    if offers.present?
      parsed_offers = []
      offers.each do |offer|
        parsed_offers.push(Offer.new(offer))
      end
      self.offers = parsed_offers
    end
  end
  def verify_response(signature, json_response)
    hash = Digest::SHA1.hexdigest(json_response + Rails.application.secrets.fyber_api_key)
    signature == hash
  end
end