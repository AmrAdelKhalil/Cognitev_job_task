class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :country_code, :phone_number, :gender, :birthdate
end
