class ChangeComment < ActiveRecord::Migration
  def change
    rename_column :comments, :description, :body
  end
end
