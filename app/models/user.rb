class User < ApplicationRecord
  after_create :assign_default_role
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :github]
  ROLES = ['Admin', 'User', 'Operator']

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
  end
  end

  def admin?
    has_role?(:admin)
  end

  def user?
    has_role?(:user)
  end

  def operator?
    has_role?(:operator)
  end

  def assign_default_role
    add_role(:user) if self.roles.blank?
  end
end
