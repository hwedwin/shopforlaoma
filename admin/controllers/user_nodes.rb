Myblog::Admin.controllers :user_nodes do
  get :index do
    @title = "User_nodes"
    @user_nodes = UserNode.all
    render 'user_nodes/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'user_node')
    @user_node = UserNode.new
    render 'user_nodes/new'
  end

  post :create do
    @user_node = UserNode.new(params[:user_node])
    if @user_node.save
      @title = pat(:create_title, :model => "user_node #{@user_node.id}")
      flash[:success] = pat(:create_success, :model => 'UserNode')
      params[:save_and_continue] ? redirect(url(:user_nodes, :index)) : redirect(url(:user_nodes, :edit, :id => @user_node.id))
    else
      @title = pat(:create_title, :model => 'user_node')
      flash.now[:error] = pat(:create_error, :model => 'user_node')
      render 'user_nodes/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "user_node #{params[:id]}")
    @user_node = UserNode.find(params[:id])
    if @user_node
      render 'user_nodes/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'user_node', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "user_node #{params[:id]}")
    @user_node = UserNode.find(params[:id])
    if @user_node
      if @user_node.update_attributes(params[:user_node])
        flash[:success] = pat(:update_success, :model => 'User_node', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:user_nodes, :index)) :
          redirect(url(:user_nodes, :edit, :id => @user_node.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'user_node')
        render 'user_nodes/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'user_node', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "User_nodes"
    user_node = UserNode.find(params[:id])
    if user_node
      if user_node.destroy
        flash[:success] = pat(:delete_success, :model => 'User_node', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'user_node')
      end
      redirect url(:user_nodes, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'user_node', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "User_nodes"
    unless params[:user_node_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'user_node')
      redirect(url(:user_nodes, :index))
    end
    ids = params[:user_node_ids].split(',').map(&:strip)
    user_nodes = UserNode.find(ids)
    
    if user_nodes.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'User_nodes', :ids => "#{ids.join(', ')}")
    end
    redirect url(:user_nodes, :index)
  end
end
