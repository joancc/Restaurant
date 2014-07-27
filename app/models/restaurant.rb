class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories
  has_one :location, dependent: :destroy

	validates :name, presence: true
  validates_presence_of :phone


  mount_uploader :image, ImageUploader
  mount_uploader :menu, MenuUploader
end
