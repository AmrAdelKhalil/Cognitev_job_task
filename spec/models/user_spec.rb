require 'rails_helper'

RSpec.describe User, type: :model do
  # email, password, first_name, last_name, country_code, phone_number, gender, birthdate, avatar
  describe 'attributes' do
    def create_user(email, first_name, last_name, country_code, phone_number, gender, birthdate, avatar)
      User.new(email: email, first_name: first_name, last_name: last_name, country_code: country_code, phone_number: phone_number, gender: gender, birthdate: birthdate, avatar: avatar)
    end

    describe 'email' do
      it 'create a valid user data with e-mail' do
        valid_user_with_email = create_user('amr@gmail.com', 'amr', 'adel', 'eg', '01111111111', 'male', '2016-01-01', 'profile.jpg')
        valid_user_with_email.save

        errors = valid_user_with_email.errors

        expect(errors.empty?).to be true
      end

      it 'create a valid user data without e-mail' do
        valid_user_without_email = create_user(nil, 'amr', 'adel', 'eg', '01111111111', 'male', '2016-01-01', 'profile.jpg')
        valid_user_without_email.save

        errors = valid_user_without_email.errors

        expect(errors.empty?).to be true
      end

      it 'create an invalid user with invalid email' do
        user = create_user('amr', 'amr', 'adel', 'eg', '01111111111', 'male', '2016-01-01', 'profile.jpg')

        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end
    end

    describe 'first_name' do
      it 'not provided' do
        user = create_user('amr@gmail.com', nil, 'adel', 'eg', '01111111111', 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end
    end

    describe 'second_name' do
      it 'not provided' do
        user = create_user('amr@gmail.com', 'amr', nil, 'eg', '01111111111', 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end
    end

    describe 'country_code' do
      it 'not valid' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'fake', '01111111111', 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end

      it 'not provided' do
        user = create_user('amr@gmail.com', 'amr', 'adel', nil, '01111111111', 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end
    end

    describe 'phone_number' do
      it 'invalid' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'fake', '01811111111', 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end

      it 'not provided' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'fake', nil, 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end

      it 'less than 11' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'fake', '0123', 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end

      it 'more than 11' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'fake', '01111111111111', 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end

      it 'not starting with 0' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'fake', '12345678910', 'male', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end
    end

    describe 'gender' do
      it 'invalid' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'eg', '01111111111', 'notHuman', '2016-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end
    end

    describe 'birthdate' do
      it 'not valid' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'eg', '01111111111', 'male', '201-01-01', 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end

      it 'is in the future' do
        date = DateTime.now
        date = date + 60 * 60 * 24 # next day
        user = create_user('amr@gmail.com', 'amr', 'adel', 'eg', '01111111111', 'male', date.strftime("%Y-%m-%d"), 'profile.jpg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end

    end

    describe 'avatar' do
      it 'not valid' do
        user = create_user('amr@gmail.com', 'amr', 'adel', 'eg', '01111111111', 'male', '201-01-01', 'profile.jg')
        user.save

        errors = user.errors

        expect(errors.empty?).not_to be true
      end
    end
  end
end
