class Location < ApplicationRecord
  belongs_to :user

  validate :geo_locate_validation

  def data_missing?
    longitude && latitude ? false : true
  end

  def geo_locate_validation
   ip_reg = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/
   zip_reg = /^\d{5}(?:[-\s]\d{4})?$/
   unless ip_reg.match?(ip_address) || zip_reg.match?(zip)
    errors.add(:ip_address, :format) unless ip_reg.match?(ip_address)
    errors.add(:zip, :format) unless zip_reg.match?(zip)
   end
  end
end
