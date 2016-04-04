require 'test_helper'
class OfferResponseTest < ActiveSupport::TestCase

  def setup
    @sample_json_body = "{\"code\":\"ERROR_INVALID_PAGE\",\"message\":\"test.\"}"
    @correct_hash = Digest::SHA1.hexdigest(@sample_json_body + Rails.application.secrets.fyber_api_key)
    @incorrect_hash = Digest::SHA1.hexdigest(@sample_json_body + "test" + Rails.application.secrets.fyber_api_key)
    @valid_response = OfferResponse.new(@correct_hash, @sample_json_body)
  end

  test "Parse data for valid responses" do
    assert @valid_response
  end

  test "Raises exception for invalid responses" do
    assert_raise do
      OfferResponse.new(@incorrect_hash, @sample_json_body)
    end
  end
end