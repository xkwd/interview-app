class AddPresenceValidationsToBasicModels < ActiveRecord::Migration[5.1]
  def change
    change_column_null :answers,     :content,             false
    change_column_null :cities,      :name,                false
    change_column_null :countries,   :name,                false
    change_column_null :interviews,  :title, :description, false
    change_column_null :sections,    :name,                false
  end
end
