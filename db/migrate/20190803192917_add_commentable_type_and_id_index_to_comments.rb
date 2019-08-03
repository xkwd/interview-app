class AddCommentableTypeAndIdIndexToComments < ActiveRecord::Migration[5.2]
  def change
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
