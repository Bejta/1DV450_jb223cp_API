class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :address
      t.float :longitude
      t.float :latitude
      t.timestamps null: false
    end
  end
end
