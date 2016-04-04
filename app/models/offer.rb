class Offer
  include ActiveModel::Model
  attr_accessor :link, :title, :thumbnail, :payout, :time_to_payout, :offer_types, :required_actions, :teaser, :offer_id, :store_id

  ["lowres", "hires"].each do |res|
    define_method("thumbnail_#{res}") do
      self.thumbnail[res]
    end
  end

end