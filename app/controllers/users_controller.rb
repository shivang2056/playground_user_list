class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User
              .ordered
              .search_by_name(search_params[:name])
  end

  def new
    @user = User.new(detail: UserDetail.new)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      respond_to do |format|
        format.html { redirect_to users_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path }
      format.turbo_stream
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def search_params
    params.permit(:name)
  end

  def user_params
    params.require(:user)
          .permit(:name, detail_attributes: [:id, :age, :email, :phone, :title])
  end
end
