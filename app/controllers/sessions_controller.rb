class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticates username and password using class method
    user = User.authenticate_with_credentials(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to :new_session
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
  
end
