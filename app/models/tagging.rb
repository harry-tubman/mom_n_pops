class Tagging < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  belongs_to :tag
end
