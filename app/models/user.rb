# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Skip email confirmation
  before_create :skip_confirmation!

  # Associations
  has_and_belongs_to_many :site_roles, optional: true
  has_many :vendor_shop_roles
  has_many :vehicles
end
