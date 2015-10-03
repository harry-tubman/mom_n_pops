class DonorshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def create
    user = User.find(params[:donated_to_id])
    current_user.donate_to(user)
    redirect_to root_path
    flash[:success] = "You are now supporting #{user.name} with your Shopping. "
  end

  def destroy
    user = Donorship.find(params[:id]).donated_to
    current_user.end_donorship_With(user)
    redirect_to choose_path
    flash[:success] = "You are no longer supporting #{user.name} with your Shopping.  Please choose another organization. "
  end
end
    
  
