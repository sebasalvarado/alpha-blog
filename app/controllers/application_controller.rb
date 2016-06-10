class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Let Rails know that the following are helper methods. This will make it available to the views.
  helper_method :current_user, :logged_in?

  def current_user
  	#Returns the user if the current session already exists, if not find it 
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	#Convert the current_user to a boolean and see if we have anyone logged in
  	!!current_user
  end

  def require_user
  	#Check if there is a logged in user or no
  	if !logged_in?
  		flash[:danger] = "You must be logged in to perform that action"
  		redirect_to root_path
  	end
  end
end
