class Commute < ApplicationRecord
  belongs_to :user
  has_many :locations, dependent: :destroy
end
