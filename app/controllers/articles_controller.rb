class ArticlesController < ApplicationController
	#Ensure we call 
	before_action :find_article, only: [:edit, :update, :show, :destroy]
	#This ensures that we require to be logged in in order to perform any action of this controller
	# except for showing the article 
	before_action :require_user, except: [:index, :show]
	#Ensure that the user who edits, updates and destroys articles is the same as the author
	before_action :require_same_user, only: [:edit, :update,:destroy]
	def index
		#Grab articles from the database
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end
	def new
		@article = Article.new
	end

	def create 
		#Create the Article instance variable
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			#Inform the User
			flash[:success] = "Article was successfully saved"
			redirect_to article_path(@article)
		else
			#The article did not pass validation filter and we shall render the new article view
			render 'new'
		end
	end

	def show
		
	end

	def edit
		
	end

	def destroy 
		
		@article.destroy

		flash[:danger] = "Article was successfully deleted"
		redirect_to articles_path
	end

	def update
		if @article.update(article_params)
			flash[:success] = "Article was successfully updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
			
	end

	#Helper method to find the article with id 
	private
		def find_article
			@article = Article.find(params[:id])
		end

	#Helper method to get the params that were passed
	private
		def article_params
			params.require(:article).permit(:title, :description)
		end

		def require_same_user
			if current_user != @article.user and !current_user.admin?
				flash[:danger] = "You can only edit or delete your own article"
				redirect_to root_path
			end
		end

end