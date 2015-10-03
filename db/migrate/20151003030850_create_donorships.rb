class CreateDonorships < ActiveRecord::Migration
  def change
    create_table :donorships do |t|
      t.integer :donor_id
      t.integer :donated_to_id

      t.timestamps null: false
    end
    
    add_index :donorships, :donor_id
    add_index :donorships, :donated_to_id
    add_index :donorships, [:donated_to_id, :donor_id], unique: true
  end
end
