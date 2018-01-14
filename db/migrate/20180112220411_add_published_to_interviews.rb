class AddPublishedToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_column :interviews, :published, :boolean, default: false
  end
end
