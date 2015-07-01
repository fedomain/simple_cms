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
		self.ranking = self.ranking - 1
		#self.save
	end

	def rankdown
		self.ranking = self.ranking + 1
		#self.save
	end

end
