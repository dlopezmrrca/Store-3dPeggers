class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :province # Add this line
  has_many :order_items, dependent: :destroy

  # Ensure stripe_payment_id is validated
  # validates :stripe_payment_id, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items", "province"] # Add "province" here
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "id_value", "stripe_payment_id", "updated_at", "province_id"] # Add "province_id" here
  end
end
