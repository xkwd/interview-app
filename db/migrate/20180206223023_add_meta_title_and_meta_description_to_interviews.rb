class AddMetaTitleAndMetaDescriptionToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_column :interviews, :meta_title, :string
    add_column :interviews, :meta_description, :string
  end
end
