require './test/test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(name: 'Example', detail: UserDetail.new(email: 'example@email.com'))

    assert user.valid?
  end

  test 'invalid without name' do
    user = User.new(name: '')

    assert_not user.valid?
    assert ["can't be blank"], user.errors[:name]
  end

  test 'invalid without detail' do
    user = User.new(name: 'Example')

    assert_not user.valid?
    assert ["can't be blank"], user.errors[:detail]
  end
end