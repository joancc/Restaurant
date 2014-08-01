class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:twitter]
  # Devise uses encrypted_password, which conflicts with password_digest from has_secure_password
  # has_secure_password


  has_many :reservations
  has_many :restaurants, through: :reservations, source: :restaurant
  has_many :stars
  has_many :starred_restaurants, through: :stars, source: :restaurant

  validates_uniqueness_of :email 

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.nickname
      user.email = auth.info.email
    end
  end

  # Override devise method to carry details from omniauth authentication attempt
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # Override password requirement when signing in through Twitter
  def password_required?
    provider.blank? && super
  end

  # Override method. If user signed up with Twitter, they won't have a password to
  # confirm any edits to their profile: users/edit
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def owner?
    self.role == 'Owner'
  end

  def patron?
    self.role == 'Patron'
  end
end
