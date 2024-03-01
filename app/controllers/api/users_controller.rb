class Api::UsersController < Api::BaseController

  def show
    @user = User.find_by_guid(params[:id])

    if @user.present?
      response_with_user_info
    else
      error_response('User not found.', :not_found)
    end
  end

  def create
    begin
      @user = User.new(user_params)

      if @user.save
        response_with_user_info
      else
        error_response(@user.errors.full_messages.join(', '), :unprocessable_entity)
      end
    rescue => exception
      error_response(exception.message)
    end
  end

  private

  def response_with_user_info
    render json: @user, serializer: Api::UserSerializer, status: :ok
  end

  def user_params
    params.require(:user).permit(:name, detail_attributes: [:title, :age, :phone, :email] )
  end
end
