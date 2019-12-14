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
  belongs_to :site_role, optional: true
  has_many :shop_users
  has_many :shops, through: :shop_users
end
