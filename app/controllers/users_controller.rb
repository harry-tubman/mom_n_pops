class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @listings = Listing.where(user: @user)
    @orders = Order.all.where(buyer: @user).order("created_at DESC")
  end
  
  def choose
    @users = User.where(:designation => "Community Organization")
  end
  
  def bank
   
   Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = params[:stripeToken]

      recipient = Stripe::Recipient.create(
        :name => current_user.first_name + " " + current_user.last_name,
        :type => "individual",
        :bank_account => token
        )

      current_user.recipient = recipient.id
      current_user.save
      
    respond_to do |format|
      if current_user.save
        format.html { redirect_to current_user, notice: 'Bank info was successfully updated :)' }
        format.json { render :show, status: :created, location: current_user }
      else
        format.html { render bank_path }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end
end
