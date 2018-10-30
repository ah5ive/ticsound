require "byebug"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :events
  has_many :favourites
  has_many :events, through: :favourites

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: [:login]

  #byebug
  require "socket"
  Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address)

  # geocoded_by :ip_address,
  #             :latitude => :lat, :longitude => :lon
  # after_validation :geocode

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  attr_writer :login

  def login
    @login || self.username || self.email
  end
end
