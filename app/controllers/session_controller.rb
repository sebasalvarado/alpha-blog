class SessionController < ApplicationController

	#Render a form to put email and password in order to log in
	def new

	end

	#Hits the database and matches the authentication field
	def create
		#Find the user based on the e-mail that we got in the Form
		user = User.find_by(email: params[:session][:email].downcase)
		#Check if the email exists
		if user && user.authenticate(params[:session][:password])
			#Save the user id in the current session hash
			session[:user_id] = user.id
			#Authenticate the user
			flash[:success] = "You have successfully loged in"
			redirect_to user_path(user)
		else
			flash.now[:danger] = "There was something wrong with login information"
			render 'new'
		end

	end

	#Method that will destroy the session and move user to log out state
	def destroy
		session[:user_id] = nil
		flash[:success] = "You have logged out"
		redirect_to root_path
	end
end