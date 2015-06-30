class ChangeRankToRankingInArticles < ActiveRecord::Migration
  def change
  	rename_column :articles, :rank, :ranking
  end
end
