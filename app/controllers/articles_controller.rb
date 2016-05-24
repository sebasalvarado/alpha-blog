class ArticlesController < ApplicationController

	def new
		@article = Article.new
	end

	def create 
		#Display the articla in JSON
		#render plain: params[:article].inspect
		@article = Article.new(article_params)
		@article.save
		#Determine the view after the article has been saved
		redirect_to articles_show(@article)
	end

	#Helper method to get the params that were passed
	private
		def article_params
			params.require(:article).permit(:title, :description)
		end

end