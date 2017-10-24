class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name, :country_code, :phone_number, :gender, :birthdate, :avatar, message: 'blank'

  validates :phone_number, format:{
    with: /\A01[0|1|2|5]\d{8}\z/, # with + regex /\A\+?[1-9]\d{10}\z/
    message: "not in E.164 format"
  }

  validates :phone_number, numericality: { only_integer: true, message: 'not_a_number'}
  validates :phone_number, length: {
    within: 11..11,
    too_short: "too short",
    too_long: "too long"
  }

  validates :email, :phone_number, :uniqueness => { message: 'taken', :allow_nil => true }

  validates_each :country_code, :gender, :birthdate, :avatar do |record, attr, value|
    record.errors.add(attr, 'inclusion') if attr == :country_code && !record.country_code?(value)
    record.errors.add(attr, 'inclusion') if attr == :gender && !record.gender?(value)
    record.errors.add(attr, 'in_the_future') if attr == :birthdate && record.future_birthdate?(value)
    record.errors.add(attr, 'invalid') if attr == :birthdate && !record.valid_birthdate?(value)
    record.errors.add(attr, 'invalid_content_type') if attr == :avatar && !record.valid_avatar?(value)
  end

  def email_required?
    !self.email.nil?
  end

  def country_code?(value)
    country_codes.include?(value) || lowered_case_country_codes.include?(value)
  end

  def gender?(value)
    value == "male" || value == "female"
  end

  def future_birthdate?(value)
    if self.valid_birthdate?(value)
      return !compare_dates(value)
    end
    false
  end

  def valid_birthdate?(value)
    regex = /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/
    !regex.match(value).nil?
  end

  def valid_avatar?(value)
    regex = /\.(jpg|jpeg|png)$/ # Ubuntu accpts files with any name except that has slashes
    !regex.match(value).nil? && value.count('/').zero?
  end

  private

  def country_codes
    ['EG']
  end

  def lowered_case_country_codes
    country_codes.map(&:downcase)
  end

  def compare_dates(value)
    DateTime.now.strftime("%Y-%m-%d") >= value
  end
end
