class AddDesignationToListings < ActiveRecord::Migration
  def change
    add_column :listings, :designation, :string
  end
end
