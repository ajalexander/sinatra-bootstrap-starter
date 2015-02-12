require_relative '../view_models/account_settings'

class App
  get '/account', :authorized => true do
    @model = AccountSettingsViewModel.new(@user)

    haml :account
  end

  post '/account', :authorized => true do
    user = User[@user.id]
    user.email_address = params[:email_address]

    if user.valid? && user.save
      flash[:success] = 'Account settings updated'
      redirect '/account'
    else
      @model = AccountSettingsViewModel.new(user)
      flash[:error] = user.errors.full_messages
      haml :account
    end
  end

  post '/password', :authorized => true do
    user = User[@user.id]

    if !user.authenticate?(params[:current_password])
      flash[:error] = 'Incorrect password'
    elsif params[:new_password] != params[:new_password_confirmation]
      flash[:error] = 'The new passwords don\'t match'
    else
      user.password = params[:new_password]

      if user.valid? && user.save
        logger.debug "Successful password change for '#{user.username}' from '#{request.ip}'"
        flash[:success] = 'Password updated'
        redirect '/account'
      else
        flash[:error] = user.errors.full_messages
      end
    end

    logger.warn "Failed password change attempt for '#{user.username}' from '#{request.ip}'"
    redirect '/account'
  end
end