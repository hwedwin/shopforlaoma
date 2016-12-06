# Helper methods defined here can be accessed in any controller or view in the application

module Myblog
  class App
    module ShareHelper
      def get_current_node

        if session[:user_node]
          if UserNode.where(id: session[:user_node]).exists?
            #若是分享的链接的节点找不到了，那么以当前用户为基础新建一个节点
            return session[:user_node]
          else
            if current_user
              if current_user.user_node
                return session[:user_node] = current_user.user_node.id
              else
                generate_root
              end
            else
              if UserNode.where(is_root: true).exists?
                return session[:user_node] = UserNode.where(is_root: true).first.id
              else
                generate_root
              end

            end

          end

        else
          #生成根节点
          generate_root

        end#if
      end#def

      def generate_root
        if  User.where(mobile: "18820965455").exists?
          @root_user = User.where(mobile: "18820965455").first
        else
          @root_user = User.new
          @root_user.username = "simontao"
          @root_user.password = Time.now.to_s
          @root_user.email = 'xsqfeaher@gmail.com'
          @root_user.mobile= '18820965455'
          @root_user.save

        end


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
          @user_node.is_root = true
          @user_node.save
          return session[:user_node] = @user_node.id
        end#if

      end

    end

    helpers ShareHelper
  end
end
