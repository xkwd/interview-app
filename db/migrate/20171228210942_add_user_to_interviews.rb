class AddUserToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :interviews, :user, foreign_key: true
  end
end
