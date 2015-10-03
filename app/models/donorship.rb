class Donorship < ActiveRecord::Base
    
  belongs_to :donor, class_name: "User"
  belongs_to :donated_to, class_name: "User"
  
  validates :donor_id, presence: true, uniqueness: true
  validates :donated_to_id, presence: true
end
