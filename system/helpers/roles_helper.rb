# Helper methods defined here can be accessed in any controller or view in the application

module Myblog
  class System
    module RolesHelper
      def outputCheck(checked)
        if checked
          return "&#10003;".html_safe
        elsif !checked
          return "&#10005;".html_safe
        end
        return "&#10005;".html_safe
      end
    end

    helpers RolesHelper
  end
end
