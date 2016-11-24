Myblog::Admin.controllers :share_nodes do
  get :index do
    @title = "Share_nodes"
    @share_nodes = ShareNode.all
    render 'share_nodes/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'share_node')
    @share_node = ShareNode.new
    render 'share_nodes/new'
  end

  post :create do
    @share_node = ShareNode.new(params[:share_node])
    if @share_node.save
      @title = pat(:create_title, :model => "share_node #{@share_node.id}")
      flash[:success] = pat(:create_success, :model => 'ShareNode')
      params[:save_and_continue] ? redirect(url(:share_nodes, :index)) : redirect(url(:share_nodes, :edit, :id => @share_node.id))
    else
      @title = pat(:create_title, :model => 'share_node')
      flash.now[:error] = pat(:create_error, :model => 'share_node')
      render 'share_nodes/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "share_node #{params[:id]}")
    @share_node = ShareNode.find(params[:id])
    if @share_node
      render 'share_nodes/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'share_node', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "share_node #{params[:id]}")
    @share_node = ShareNode.find(params[:id])
    if @share_node
      if @share_node.update_attributes(params[:share_node])
        flash[:success] = pat(:update_success, :model => 'Share_node', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:share_nodes, :index)) :
          redirect(url(:share_nodes, :edit, :id => @share_node.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'share_node')
        render 'share_nodes/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'share_node', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Share_nodes"
    share_node = ShareNode.find(params[:id])
    if share_node
      if share_node.destroy
        flash[:success] = pat(:delete_success, :model => 'Share_node', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'share_node')
      end
      redirect url(:share_nodes, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'share_node', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Share_nodes"
    unless params[:share_node_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'share_node')
      redirect(url(:share_nodes, :index))
    end
    ids = params[:share_node_ids].split(',').map(&:strip)
    share_nodes = ShareNode.find(ids)
    
    if share_nodes.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Share_nodes', :ids => "#{ids.join(', ')}")
    end
    redirect url(:share_nodes, :index)
  end
end
