class AddCountryToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :interviews, :country, foreign_key: true
  end
end
