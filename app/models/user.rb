class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:phone_number]

  has_many :statuses
  include AuthenticationToken
  include CustomValidation

  protected
    def password_required?
      false
    end

end
