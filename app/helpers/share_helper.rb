# Helper methods defined here can be accessed in any controller or view in the application

module Myblog
  class App
    module ShareHelper
      def get_current_node(product)

        if session[:user_node]
          return session[:user_node]
        else
          @root_user = User.where(mobile: "18820965455").first
          if UserNode.where(user: @root_user).exists?
            @user_node  = UserNode.where(user: @root_user).first
            if !@user_node.is_root
              @user_node.is_root = true
            end
            return session[:user_node] = @user_node.id
          else
            @user_node  = UserNode.new
            @user_node.user = @root_user
            @user_node.seller = @root_user.id
            @user_node.product = product
            @user_node.is_root = true
            @user_node.save
            return session[:user_node] = @user_node.id
          end#if

        end#if
      end#def

    end

    helpers ShareHelper
  end
end
