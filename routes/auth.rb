class App

  get '/login' do
    haml :login
  end

  post '/login' do
    user = User.find_by_username(params[:username])
    if user && user.authenticate?(params[:password])
      logger.debug "Successful login for '#{params[:username]}' from '#{request.ip}'"

      session[:user] = user.id
      redirect '/'
    else
      logger.warn "Failed login attempt for '#{params[:username]}' from '#{request.ip}'"
      flash[:error] = "Invalid login attempt"
      haml :login
    end
  end

  get '/logout', :authorized => true do
    session[:user] = nil
    redirect '/login'
  end
end