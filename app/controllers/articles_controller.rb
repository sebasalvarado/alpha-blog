class ArticlesController < ApplicationController
	def index
		#Grab articles from the database
		@all_articles = Article.all
	end
	def new
		@article = Article.new
	end

	def create 
		#Create the Article instance variable
		@article = Article.new(article_params)
		if @article.save
			#Inform the User
			flash[:notice] = "Article was successfully saved"
			redirect_to article_path(@article)
		else
			#The article did not pass validation filter and we shall render the new article view
			render 'new'
		end
	end

	def show
			@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end


	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Article was successfully updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
			
	end

	#Helper method to get the params that were passed
	private
		def article_params
			params.require(:article).permit(:title, :description)
		end

end