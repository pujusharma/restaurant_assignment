# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: %i[google_oauth2,facebook]
  include DeviseTokenAuth::Concerns::User

  validates :email, confirmation: true, uniqueness: true
  validates :first_name, :last_name, :email, presence: true




  def self.from_omniauth(auth)
    # This line checks if the user email received by the Omniauth is already included in our databases.
      user = User.where(email: auth.info.email).first
    # This line sets the user unless there is a user found in the line above, therefore we use ||= notation to evaluate if the user is nill, then set it to the User.create
    . 
      user ||= User.create!(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20])
      config.credentials = [:facebook]
      user
    end

    private
    def set_auth_token
      if self.authentication_token.blank?
        self.authentication_token = generate_authentication_token
      end
    end
  
    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
