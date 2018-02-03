class AddCoverToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_column :interviews, :cover, :string
  end
end
