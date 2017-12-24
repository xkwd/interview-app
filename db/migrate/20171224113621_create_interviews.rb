class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.string :title
      t.datetime :published_at
      t.text :description

      t.timestamps
    end
  end
end
