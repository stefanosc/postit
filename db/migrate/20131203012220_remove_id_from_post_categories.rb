class RemoveIdFromPostCategories < ActiveRecord::Migration
  def change
    remove_column(:post_categories, :id)
  end
end
