class ChangeTypeContentToString < ActiveRecord::Migration[7.2]
  def change
    change_column :posts, :content, :string
    change_column :comments, :content, :string
  end
end
