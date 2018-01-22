class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :commentable_type
      t.integer :commentable_id
      t.references :user, foreign_key: true
      t.string :commenter_name
      t.string :commenter_email

      t.timestamps
    end
  end
end
