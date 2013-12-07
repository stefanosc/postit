class AddTimestampsToPostCategories < ActiveRecord::Migration
  def change
    add_timestamps :post_categories
  end
end
