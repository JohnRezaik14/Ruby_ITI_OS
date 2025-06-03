class AddReportsCountAndStatusToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :status, :string, default: "published"
  end
end
