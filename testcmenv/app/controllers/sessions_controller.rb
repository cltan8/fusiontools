class SessionsController < ApplicationController  
  layout "sessions/layouts/sessions"
  include SessionsHelper
  before_action :require_login, except: [:loginpage, :login]
 
  def index
    respond_to do |format|
      format.html
    end
  end

  def loginpage
    if logged_in?
      redirect_to :action => "index"
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def login
    puts "Email: #{params[:session][:email]}"
    puts "Password: #{params[:session][:password]}"
    if params[:session][:email] == "aaa@aaa.com"      
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      logout
    else
      log_in(params[:session])
      redirect_to :action => "index"
    end
    
  end

  def logout
    log_out
    redirect_to "/secure"
  end

private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to "/secure"
    end
  end

end
