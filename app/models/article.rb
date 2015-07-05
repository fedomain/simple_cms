class Article < ActiveRecord::Base

	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: { minimum: 5 }

	def self.find_by_rank(id, rank)
		@this_article = find(id)

		if (rank == "up")
			@next_article = find_by(ranking: @this_article.ranking.to_i-1, category_id: @this_article.category_id)
		else
			@next_article = find_by(ranking: @this_article.ranking.to_i+1, category_id: @this_article.category_id)
		end
	end


	def self.rank(id, rank)
		@this_article = find(id)

		if (rank == "up")
			@next_article = find_by(ranking: @this_article.ranking.to_i-1, category_id: @this_article.category_id)

			@this_article.rankup
			@next_article.rankdown
		else
			@next_article = find_by(ranking: @this_article.ranking.to_i+1, category_id: @this_article.category_id)

			@this_article.rankdown
			@next_article.rankup
		end
	end

	def self.rerank(id)
		@this_article = find(id)
		@start_rank = @this_article.ranking
		@next_articles = where(["ranking > ?", @start_rank]).order('ranking ASC')

		@next_articles.each do |article| 
			article.ranking = @start_rank
			article.save

			@start_rank = @start_rank + 1
		end
	end

	def rankup
		#swap_rank(self.id, self.ranking, self.category_id, rank)

		#@affected_article = Article.find_by(ranking: ranking.to_i-1, category_id: category_id)
		
		#self.ranking = self.ranking - 1
		#@affected_article.ranking = @affected_article.ranking + 1

		#Article.transaction do
		#	self.save
		#	@affected_article.save
		#end

		@affected_article = Article.find_by(ranking: ranking-1, category_id: category_id)

		swap_rank(@affected_article)

	end

	def rankdown
		#swap_rank(self.id, self.ranking, self.category_id, rank)

		#@affected_article = Article.find_by(ranking: ranking.to_i+1, category_id: category_id)

		#self.ranking = self.ranking + 1
		#@affected_article.ranking = @affected_article.ranking - 1

		#Article.transaction do
		#	self.save
		#	@affected_article.save
		#end

		@affected_article = Article.find_by(ranking: ranking+1, category_id: category_id)

		swap_rank(@affected_article)
	end

	private

	def swap_rank(affected_article)
		#if (rank == 'up')
		#	@affected_article = Article.find_by(ranking: ranking.to_i-1, category_id: category_id)
		#	@affected_article.ranking = @affected_article.ranking + 1
		#else
		#	@affected_article = Article.find_by(ranking: ranking.to_i+1, category_id: category_id)
		#	@affected_article.ranking = @affected_article.ranking - 1
		#end

		#@affected_article.save

		@current_ranking = self.ranking

		self.ranking = affected_article.ranking
		affected_article.ranking = @current_ranking

		Article.transaction do
			self.save
			affected_article.save
		end

	end
end
