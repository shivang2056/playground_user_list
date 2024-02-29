require './test/test_helper'

class UserDetailTest < ActiveSupport::TestCase
  setup do
    @user = User.find_by_name('Savannah Marks')
  end

  test 'valid detail' do
    user_detail = UserDetail.new(email: 'example@email.com',
                    user: User.new(name: 'Example'))

    assert user_detail.valid?
  end

  test 'invalid without email' do
    user_detail = UserDetail.new(phone: '123456',
                    user: User.new(name: 'Example'))

    assert_not user_detail.valid?
    assert ["can't be blank"], user_detail.errors[:email]
  end
end