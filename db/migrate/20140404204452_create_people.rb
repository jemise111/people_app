class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :birthdate
      t.integer :drinks
      t.string :image_url
      t.boolean :license
    end
  end
end
