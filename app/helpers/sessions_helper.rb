module SessionsHelper
  
  def sign_in(user)
    # Using a cookie to permanently remember a signed in users => 
    # cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    # Using the session helper method to maintain user signin => 
    session[:remember_token] = [user.id, user.salt]
    current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    # Using a cookie to permanently remember a signed in users => 
    # cookies.delete(:remember_token)
    # Using the session helper method to maintain user signin => 
    session[:remember_token] = [nil,nil]
    current_user = nil
  end
  
  private
  
    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      # Using a cookie to permanently remember a signed in users => 
      # cookies.signed[:remember_token] || [nil,nil]
      # Using the session helper method to maintain user signin => 
      session[:remember_token] || [nil,nil]
    end
  
end
