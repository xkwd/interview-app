class AddImageToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :image, :string
  end
end
