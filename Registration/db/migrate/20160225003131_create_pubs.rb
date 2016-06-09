class CreatePubs < ActiveRecord::Migration
  def change
    create_table :pubs do |t|
      t.string :name, :null => false
      t.string :description, :null => false
      t.integer :rating, :null => false
      t.belongs_to :position
      t.belongs_to :creator
      t.timestamps null: false
    end
  end
end
