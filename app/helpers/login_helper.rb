# Helper methods defined here can be accessed in any controller or view in the application

module Myblog
  class App
    module LoginHelper
      # def simple_helper_method
      # ...
      # end
      def current_user
        session[:user]

      end

      def set_current_user(user)
        session[:user] = user
      end

      def destroy_current_user
        session[:user] = nil
      end

    end

    helpers LoginHelper
  end
end
