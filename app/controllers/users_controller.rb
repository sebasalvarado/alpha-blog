class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update, :show]
	#Ensure that the user who edits and updates a profile is its own user.
	before_action :require_same_user, only:[:edit,:update]
	def new
		@user = User.new
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 5)

	end

	def create 
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Welcome to Alpha Blog #{@user.username}"
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def edit 
		#find user ID

	end

	def update

		if @user.update(user_params)
			flash[:success] = "Your account was updated successfully!"
			redirect_to articles_path

		else
			render 'edit'
		end
	end

	def show
		#Find the user to show
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end
	private 
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	#Have the @user instance variable ready to use before edit, update and show
	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
		if current_user != @user
			flash[:danger] = "You can only edit your own account"
			redirect_to root_path
		end
	end
end