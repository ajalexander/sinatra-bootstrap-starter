require 'haml'
require 'logger'
require 'rack-flash'
require 'rack/protection'
require 'sinatra'
require 'sinatra/json'

class App < Sinatra::Base
  configure do
    require 'dotenv'
    Dotenv.load

    set :session_expiration, 300 # 5 minutes
  end

  configure :development do
    enable :logging

    require 'sinatra/reloader'
    register Sinatra::Reloader

    # Uncomment the following to test the error handler in development
    #set :show_exceptions, false
  end

  configure :test do
    disable :logging
  end
  
  configure :production do
    enable :logging
  end

  before do
    if settings.logging
      log_directory = "#{File.dirname(__FILE__)}/log"

      Dir.mkdir(log_directory) if !Dir.exist?(log_directory)
      
      env["rack.logger"] = Logger.new(
        "#{log_directory}/#{settings.environment}.log",
        'daily')
    end
  end

  use Rack::Session::Cookie, secret: ENV['SESSION_SECRET'], expire_after: settings.session_expiration
  use Rack::Flash, sweep: true

  use Rack::Protection

  before do
    @user = session[:user].nil? ? nil : User[session[:user]]
  end

  set(:authorized) do |enforce|
    condition do
      return if !enforce
      
      if @user.nil?
        logger.warn "Invalid or missing session: #{request.path}"

        session[:user] = nil
        flash[:warning] = "Invalid session. Please login again."
        redirect '/login'
      end
    end
  end

  not_found do
    logger.error "Page not found: #{request.path}"
    haml :not_found
  end

  error do
    error = env['sinatra.error']
    logger.error "#{error.class} - #{error.message}"
    haml :error
  end
end

require_relative 'models/init'
require_relative 'routes/init'