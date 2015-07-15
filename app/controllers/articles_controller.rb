class ArticlesController < ApplicationController
	before_filter :authorize, only: [:edit, :update, :destroy]

	def index
		@selected_category_id = params[:category_id]
		@categories = Category.all.order('name ASC')

		if (params[:category_id])
			@articles = Article.all.where(["category_id = ?", params[:category_id]]).order('ranking')
		else
			@articles = Article.all.order('category_id ASC, title')
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
		@article.category_id = params[:category_id]
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@new_rank = Article.all.where(["category_id = ?", article_params[:category_id]]).order('ranking').last.ranking+1
		@article = Article.new(article_params)
		@article.ranking = @new_rank

		if @article.save
			redirect_to articles_path(category_id: article_params[:category_id])
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params)
			redirect_to @article
		else 
			render 'edit'
		end
	end

	def destroy
		Article.rerank(params[:id])
		
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end

	def rank
		@this_article = Article.find(params[:id])
		#@affected_article = Article.find_by_rank(params[:id], params[:rank])

		if (params[:rank] == 'up')
			@this_article.rankup
			#@affected_article.rankdown
		else
			@this_article.rankdown
			#@affected_article.rankup
		end

		#@this_article.save
		#@affected_article.save

		redirect_to articles_path(category_id: Article.find(params[:id]).category_id)
	end

	private

	def article_params
		params.require(:article).permit(:title, :text, :category_id)
	end
end
