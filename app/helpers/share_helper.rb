# Helper methods defined here can be accessed in any controller or view in the application

module Myblog
  class App
    module ShareHelper
      def get_current_node
        if session[:user_node]
          session[:user_node]
        else
          @root_user = User.where(mobile: "18820965455").first
          if UserNode.where(user_id: @root_user.id).exists?
            @user_node  = UserNode.where(user_id: @root_user.id).first
            session[:user_node] = @user_node.id
          else
            @user_node  = UserNode.new
            @user_node.user = @root_user
            @user_node.seller = @root_user.id
            @user_node.save
            session[:user_node] = @user_node.id
          end


        end

      end
    end

    helpers ShareHelper
  end
end
