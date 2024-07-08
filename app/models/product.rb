class Product < ApplicationRecord
  validates :name, :description, :price, presence: true
  validates :name , uniqueness: true
  validates :description, length: { maximum: 500 }
  has_many_attached :images
  belongs_to :category, optional: true

  def self.ransackable_associations(auth_object = nil)
    ["images_attachments", "images_blobs"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "price", "updated_at"]
  end
end
