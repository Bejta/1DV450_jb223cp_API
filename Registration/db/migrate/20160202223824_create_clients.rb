class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :apikey, :null => false
      t.string :name, :null => false
      t.string :description, :null => false, :limit => 500
      t.string :url
      t.boolean :active, :null => false, :default => true
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
