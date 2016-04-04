require 'test_helper'
class OfferRequestTest < ActiveSupport::TestCase

  def setup
    @valid_req = OfferRequest.new(uid: 1, pub0: "campaign1", page: 1)
    @invalid_req = OfferRequest.new(uid: 1, pub0: "campaign1")
  end

  test "Validity of offer request" do
    assert @valid_req.valid?
  end

  test "Invalidity of offer request" do
    assert_not @invalid_req.valid?
  end

  test "Get offer response from valid request" do
    assert @valid_req.get_offers
  end

  test "Get offer response from invalid request with missing params" do
    assert_not @invalid_req.get_offers
  end

  test "Hash validity" do
    sorted_query = Hash[@valid_req.as_json(except: ["validation_context", "errors","hashkey"]).sort].to_query
    sorted_query += "&#{Rails.application.secrets.fyber_api_key}"
    hash = Digest::SHA1.hexdigest sorted_query
    assert hash == @valid_req.hashkey
  end
end