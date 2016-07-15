class ArticlesController < ApplicationController
	http_basic_authenticate_with name:"mdd", password:"muktesh",except: [:index, :show]
	
	def index
		@articles= Article.all
	end

	def new
		@article=Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def show
		@article = Article.find(params[:id])
	end

	def create
		#render plain: params[:article].inspect
		#@article=Article.new(params[:article])
		#@article = Article.new(params.require(:article).permit(:title,:text))
		@article = Article.new(article_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end
	
	private
		def article_params
			params.require(:article).permit(:title,:text)
		end
end
