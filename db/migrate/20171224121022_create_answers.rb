class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :content
      t.references :interview, foreign_key: true
      t.references :section, foreign_key: true

      t.timestamps
    end
  end
end
