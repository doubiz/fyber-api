class OfferRequest
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Serialization
  #Constants
  GET_OFFERS_URL = "http://api.fyber.com/feed/v1/offers.json?"
  DEFAULT_HASH = {appid: 157, format: "json", device_id: "2b6f0cc904d137be2e1730235f5664094b83",
                  locale: "de", ip: "109.235.143.113", offer_types: 112}
  #Attributes
  attr_accessor :format, :appid, :uid, :locale, :os_version, :timestamp,
                :hashkey, :apple_idfa, :apple_idfa_tracking_enabled, :ip,
                :pub0, :page, :offer_types, :ps_time, :device_id, :page
  #Validations
  validates_presence_of :format, :appid, :uid, :locale, :timestamp,
                        :hashkey, :pub0, :page
  #Constructor
  def initialize(options = {})
    options = DEFAULT_HASH.merge(options)
    super
    self.timestamp = Time.now.to_i
    set_hashkey
  end

  #Instance Methods
  def offers_get_url
    GET_OFFERS_URL + self.as_json(except: ["validation_context", "errors"]).to_query
  end

  def get_offers
    if self.valid?
      url = URI.parse(self.offers_get_url)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      if res.code == "200"
        response_signature = res["X-Sponsorpay-Response-Signature"]
        begin 
          return OfferResponse.new(response_signature, res.body)
        rescue
          return false
        end
      else
        # Encountered a status message that is not 200
        self.errors = res.body
        return false
      end
    else
      # Request is invalid missing params
      return false
    end
  end

  #Private Methods
  private

  def set_hashkey
    sorted_hash_of_params = Hash[self.as_json.sort]
    sorted_query = sorted_hash_of_params.to_query
    sorted_query += "&#{Rails.application.secrets.fyber_api_key}"
    self.hashkey = Digest::SHA1.hexdigest sorted_query
  end

  # {appid: 157, format: "json", device_id: "2b6f0cc904d137be2e1730235f5664094b83", locale: "de", ip: "109.235.143.113", offer_types: 112}

end