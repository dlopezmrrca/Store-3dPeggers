
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Province.create([
  { province_name: 'Alberta', gst_rate: 0.05, hst_rate: 0, pst_rate: 0, qst_rate: 0 },
  { province_name: 'British Columbia', gst_rate: 0.05, hst_rate: 0, pst_rate: 0.07, qst_rate: 0 },
  { province_name: 'Manitoba', gst_rate: 0.05, hst_rate: 0, pst_rate: 0.07, qst_rate: 0 },
  { province_name: 'New Brunswick', gst_rate: 0, hst_rate: 0.15, pst_rate: 0, qst_rate: 0 },
  { province_name: 'Newfoundland and Labrador', gst_rate: 0, hst_rate: 0.15, pst_rate: 0, qst_rate: 0 },
  { province_name: 'Northwest Territories', gst_rate: 0.05, hst_rate: 0, pst_rate: 0, qst_rate: 0 },
  { province_name: 'Nova Scotia', gst_rate: 0, hst_rate: 0.15, pst_rate: 0, qst_rate: 0 },
  { province_name: 'Nunavut', gst_rate: 0.05, hst_rate: 0, pst_rate: 0, qst_rate: 0 },
  { province_name: 'Ontario', gst_rate: 0, hst_rate: 0.13, pst_rate: 0, qst_rate: 0 },
  { province_name: 'Prince Edward Island', gst_rate: 0, hst_rate: 0.15, pst_rate: 0, qst_rate: 0 },
  { province_name: 'Quebec', gst_rate: 0.05, hst_rate: 0, pst_rate: 0, qst_rate: 0.09975 },
  { province_name: 'Saskatchewan', gst_rate: 0.05, hst_rate: 0, pst_rate: 0.06, qst_rate: 0 },
  { province_name: 'Yukon', gst_rate: 0.05, hst_rate: 0, pst_rate: 0, qst_rate: 0 }
])
