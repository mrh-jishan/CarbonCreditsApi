class User < ApplicationRecord
  has_many :commutes, dependent: :destroy
  has_many :locations, :through => :commutes, dependent: :destroy

  validates_presence_of :email
end
