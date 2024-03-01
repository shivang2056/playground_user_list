require './test/test_helper'

class Api::UsersControllerTest < ActionController::TestCase

  test "users#show valid request" do
    existing_user = User.find_by_name('Lyla Bode')

    get :show, params: { id: existing_user.guid }

    assert_response :success

    parsed_response = JSON.parse response.body

    assert_equal 'Lyla Bode', parsed_response['name']
    assert_equal 'briana.fay@gmail.com', parsed_response['detail']['email']
    assert_equal '310.294.7075', parsed_response['detail']['phone']
    assert_equal '39', parsed_response['detail']['age']
    assert_equal 'Prof.', parsed_response['detail']['title']
  end

  test "users#show invalid request" do
    get :show, params: { id: 'test_id' }

    assert_response :not_found

    parsed_response = JSON.parse response.body

    assert_equal 'User not found.', parsed_response['error']
  end

  test "users#create valid request" do
    assert_difference 'User.count', 1 do
      post :create, params: user_params
    end

    assert_response :success

    parsed_response = JSON.parse response.body

    assert_equal 'test123', parsed_response['name']
    assert_equal 'asd123@asd123.com', parsed_response['detail']['email']
    assert_equal '6542345', parsed_response['detail']['phone']
    assert_equal '20', parsed_response['detail']['age']
    assert_equal 'Mr.', parsed_response['detail']['title']
  end

  test "users#create invalid request -> name & email not present" do
    invalid_params = user_params.dup
    invalid_params[:user][:name] = nil
    invalid_params[:user][:detail_attributes][:email] = nil

    assert_difference 'User.count', 0 do
      post :create, params: invalid_params
    end

    assert_response :unprocessable_entity

    parsed_response = JSON.parse response.body

    assert_equal "Detail email can't be blank, Name can't be blank", parsed_response['error']
  end

  test "users#create invalid request -> title is incorrect" do
    invalid_params = user_params.dup
    invalid_params[:user][:detail_attributes][:title] = 'Professor'

    assert_difference 'User.count', 0 do
      post :create, params: invalid_params
    end

    assert_response :internal_server_error

    parsed_response = JSON.parse response.body

    assert_equal "'Professor' is not a valid title", parsed_response['error']
  end

  def user_params
    {
      user: {
        name: 'test123',
        detail_attributes: {
          email: 'asd123@asd123.com',
          phone: '6542345',
          age: 20,
          title: 'Mr.'
        }
      }
    }
  end
end
