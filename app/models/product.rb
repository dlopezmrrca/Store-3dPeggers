class Product < ApplicationRecord
  validates :name, :description, :price, presence: true
  validates :name , uniqueness: true
  validates :description, length: { maximum: 2000 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :images, presence: true
  validates :images, length: { minimum: 1 }
  validates :category, presence: true
  has_many_attached :images
  belongs_to :category, optional: true
  has_many :cart_items

  def self.ransackable_associations(auth_object = nil)
    ["images_attachments", "images_blobs"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "price", "updated_at"]
  end
end
