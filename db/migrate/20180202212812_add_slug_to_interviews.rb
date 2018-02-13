class AddSlugToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_column :interviews, :slug, :string
    add_index :interviews, :slug, unique: true
  end
end
