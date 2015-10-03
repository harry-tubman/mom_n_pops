class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :name, presence: true
  validates :designation, presence: true
  has_many :listings, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"
  
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :tags, through: :taggings
  has_attached_file :avatar, :styles => { :medium => "200x", :thumb => "100x100>", :tiny => "50x50>"  }, :default_url => "default.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  has_many :active_donorships, class_name:  "Donorship",
                                  foreign_key: "donor_id",
                                  dependent:   :destroy
  has_many :passive_donorships, class_name:  "Donorship",
                                   foreign_key: "donated_to_id",
                                   dependent:   :destroy
  has_many :donating_to, through: :active_donorships, source: :donated_to
  has_many :donors, through: :passive_donorships, source: :donor
  
  
   # Chooses a non-profit to donate to.
  def donate_to(other_user)
    active_donorships.create(donated_to_id: other_user.id)
  end

  # Ends donor relationship with a non-profit.
  def end_donorship_With(other_user)
    active_donorships.find_by(donated_to_id: other_user.id).destroy
  end

  # Returns true if the current user is donating to the other user.
  def donating_to?(other_user)
    donating_to.include?(other_user)
  end
  
  
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
