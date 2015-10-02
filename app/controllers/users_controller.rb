class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @listings = Listing.where(user: @user)
    @orders = Order.all.where(buyer: @user).order("created_at DESC")
  end

end
