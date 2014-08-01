class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :stars
  has_many :starred_by, through: :stars, source: :user

  has_many :reservations
  has_many :users, through: :reservations

  has_one :location, dependent: :destroy

	validates :name, presence: true
  validates_presence_of :phone

  mount_uploader :image, ImageUploader
  mount_uploader :menu, MenuUploader
end
