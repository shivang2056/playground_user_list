module UserHelper

  def header_user_name
    @user.persisted? && @user.name.presence || 'New User'
  end
end
