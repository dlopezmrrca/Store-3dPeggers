class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  before_create :set_cart_id

  enum :status, ["pending", "complete"]

  private
  def set_cart_id
    self.cart_id = SecureRandom.uuid + DateTime.now.to_i.to_s
  end
end
