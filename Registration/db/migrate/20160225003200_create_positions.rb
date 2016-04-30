class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :address
      t.float :longitude
      t.float :latitude
      t.belongs_to :pub, index: true
      t.timestamps null: false
    end
  end
end
