class CreateUps < ActiveRecord::Migration
  def change
    create_table :ups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
