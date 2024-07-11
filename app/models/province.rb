class Province < ApplicationRecord
  validates :province_name, presence: true
  validates :gst_rate, :hst_rate, :pst_rate, :qst_rate, numericality: { greater_than_or_equal_to: 0 }

end
