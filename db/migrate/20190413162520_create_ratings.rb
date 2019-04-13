class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.boolean :positive, null: false
      t.references :user, foreign_key: true, null: false
      t.references :comment, foreign_key: true, null: false

      t.timestamps
    end
  end
end
