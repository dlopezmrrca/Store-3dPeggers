class Customer < ApplicationRecord
  has_many :orders
  has_many :shopping_cart_items, through: :shopping_cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def self.ransackable_attributes(auth_object = nil)
          ["created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
        end
end
