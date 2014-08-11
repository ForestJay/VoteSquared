class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |t|
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :state
      t.string :current_office

      t.timestamps
    end
  end
end
