class Province < ApplicationRecord
  validates :province_name, presence: true
  validates :gst_rate, :hst_rate, :pst_rate, :qst_rate, numericality: { greater_than_or_equal_to: 0 }
  has_many :customers


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst_rate", "hst_rate", "id", "id_value", "province_name", "pst_rate", "qst_rate", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customers"]
  end

end
