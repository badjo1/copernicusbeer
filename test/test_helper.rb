ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Logs in a test user.
  def log_in_as(user, options = {})
    remember_me = options[:remember_me] || '1'
    post login_path, params: { user_session: { eth_address: user.eth_address, eth_message: 'fLFRSkCea_N5RLKAJqyYCw', eth_signature: '0x5b656af34dec5fee4e58305a50fdb464e287bc9d6dc98134b31ccabd4efbc9306d6233cbcab515154228d66659610826aa717a5a92781c35a0331a8263ee60c41c', remember_me: remember_me } }
    
    # if integration_test?
    #   get login_path
    #   post login_path, params: { user_session: { eth_address: @user.eth_address, eth_message: 'message', eth_signature: 'signature' } }
    #   # post login_path, user_session: { email:       user.email,
    #   #                             password:    password,
    #   #                             remember_me: remember_me }
    # else
    #   session[:user_id] = user.id
    # end
  end


  private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end

end
