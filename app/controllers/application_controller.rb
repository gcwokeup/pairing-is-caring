class ApplicationController < ActionController::Base
  helper_method :signed_in_root_path

  def signed_in_root_path(current_user)
    # TODO: Change to user home path when that page is done
    user_path(current_user)
  end

  def find_or_activate_by_email
    user = User.find_by_email(params[:email])
    unless user
      user = User.create!(user_params).send_activation
      flash[:notice] = "Please go check your email, ok?"
    end
    user
  end

  def user_params
    [:first_name, :last_name, :username, :email].inject({}) { |hash, attribute| hash.merge(attribute => params[attribute]) }
  end
end
