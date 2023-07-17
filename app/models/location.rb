class Location < ApplicationRecord
  belongs_to :user

  def data_missing
    longitude && latitude
  end
end
