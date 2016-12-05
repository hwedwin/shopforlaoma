# Helper methods defined here can be accessed in any controller or view in the application

module Myblog
  class System
    module LoginHelper
      def current_admin
        session[:admin]

      end

      def set_current_admin(admin)
        session[:admin] = admin
      end

      def destroy_current_admin
        session[:admin] = nil
      end
    end

    helpers LoginHelper
  end
end
