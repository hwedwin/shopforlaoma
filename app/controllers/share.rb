Myblog::App.controllers :share do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :index, :with => :id do

    if params[:product_id]
      @product = Product.find(params[:product_id])
    else
      @product = Product.first
    end
    if params[:id].nil?
      redirect url(:login, :index)
    end
    session[:user_node] = params[:id]
    if current_user
      #是否已经登录
      @title = '来自老猫商城，分享得丰厚佣金'
      if UserNode.where(id: session[:user_node]).exists?
        #若是旧的数据没有链接，则重新生成
        @fuser_node = UserNode.find(session[:user_node])
      else
        @fuser_node = UserNode.find(get_current_node)
      end

      @mobile = @fuser_node.user.mobile
      if @fuser_node.user == User.find(current_user.id)
        #判断此页是不是打开的是自己的链接
        session[:user_node] = params[:id]

      else
        if current_user.user_node
          #判断当前用户有没有在某个分享链接中
          if @fuser_node.is_root
            session[:user_node] = current_user.user_node.id
            redirect url(:share, :index, :id => session[:user_node])
          else
              #若当然节点不是根节点，则
            if current_user.user_node.product == @fuser_node.product
              #判断当前用户所在的分享链接中是不是和当前分享在同一个产品下
              session[:user_node] = current_user.user_node.id
              redirect url(:share, :index, :id => session[:user_node])
            else
              #断开当前用户的分销链，并且链接到当前父节点下
              current_user.user_node = @fuser_node
              current_user.save
              session[:user_node] = current_user.user_node.id
              redirect url(:share, :index, :id => session[:user_node])
            end
          end

        else
          #若是当前用户不在一个分销链上，则新建一个节点
          @new_user_node = UserNode.new
          @new_user_node.seller = @fuser_node.seller
          @new_user_node.user = User.find(current_user.id)
          @new_user_node.parent_node = @fuser_node.id
          @new_user_node.user_node = @fuser_node
          @new_user_node.is_root = false
          if params[:product_id]
            @new_user_node.product = Product.find(params[:product_id]).id
          else
            @new_user_node.product = Product.first.id
          end

          @new_user_node.save
          session[:user_node] = @new_user_node.id
          redirect url(:share, :index, :id => session[:user_node])

        end

      end
    else
      #若是没有登录
      #将当前参数写入父节点中
      if session[:is_from_share]
        session[:is_from_share] = true
        redirect url(:login, :index)
      else
        session[:is_from_share] = true
        session[:product_id] = params[:product_id]
        redirect url("products/"+params[:product_id])
      end


    end

    render 'share/index'

  end



end
