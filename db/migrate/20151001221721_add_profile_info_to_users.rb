class AddProfileInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street_address, :string
    add_column :users, :city, :string, index: true
    add_column :users, :state, :string, index: true
    add_column :users, :country, :string, index: true
    add_column :users, :zip, :string, index:true
    add_column :users, :website, :string
    add_column :users, :phone, :string
    add_column :users, :info, :text
    add_column :users, :image, :attachment
  end
end
