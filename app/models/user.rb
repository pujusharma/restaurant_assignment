# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: %i[google_oauth2]
  include DeviseTokenAuth::Concerns::User

  def self.from_omniauth(auth)
    # This line checks if the user email received by the Omniauth is already included in our databases.
      user = User.where(email: auth.info.email).first
    # This line sets the user unless there is a user found in the line above, therefore we use ||= notation to evaluate if the user is nill, then set it to the User.create
    . 
      user ||= User.create!(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20])
      user
    end
end
