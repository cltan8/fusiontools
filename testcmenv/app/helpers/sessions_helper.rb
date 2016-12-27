module SessionsHelper
  # Logs in the given user.
  def log_in(p)
    session[:userid] = p[:email];
    session[:password] = p[:password];
    session[:logindt] = Time.new.inspect;
    puts "Session User Id: #{session[:userid]}"
    puts "Session Password: #{session[:password]}"
    puts "Session Date Time #{session[:logindt]}"
    p[:email] == "admin@aaa.com" ? session[:isadmin] = 1 : session[:isadmin] = 0
    puts "Session Administrator #{session[:isadmin]}"
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= session[:userid]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    clearusersession
    @current_user = nil
  end

  def clearusersession
    session[:userid] = nil
    session[:password] = nil
    session[:logindt] = nil
    session[:isadmin] = nil
  end

end
