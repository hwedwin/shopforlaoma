Myblog::Admin.controllers :access_controllers do
  get :index do
    @title = "Access_controllers"
    @access_controllers = AccessController.all
    render 'access_controllers/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'access_controller')
    @access_controller = AccessController.new
    render 'access_controllers/new'
  end

  post :create do
    @access_controller = AccessController.new(params[:access_controller])
    if @access_controller.save
      @title = pat(:create_title, :model => "access_controller #{@access_controller.id}")
      flash[:success] = pat(:create_success, :model => 'AccessController')
      params[:save_and_continue] ? redirect(url(:access_controllers, :index)) : redirect(url(:access_controllers, :edit, :id => @access_controller.id))
    else
      @title = pat(:create_title, :model => 'access_controller')
      flash.now[:error] = pat(:create_error, :model => 'access_controller')
      render 'access_controllers/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "access_controller #{params[:id]}")
    @access_controller = AccessController.find(params[:id])
    if @access_controller
      render 'access_controllers/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'access_controller', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "access_controller #{params[:id]}")
    @access_controller = AccessController.find(params[:id])
    if @access_controller
      if @access_controller.update_attributes(params[:access_controller])
        flash[:success] = pat(:update_success, :model => 'Access_controller', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:access_controllers, :index)) :
          redirect(url(:access_controllers, :edit, :id => @access_controller.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'access_controller')
        render 'access_controllers/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'access_controller', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Access_controllers"
    access_controller = AccessController.find(params[:id])
    if access_controller
      if access_controller.destroy
        flash[:success] = pat(:delete_success, :model => 'Access_controller', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'access_controller')
      end
      redirect url(:access_controllers, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'access_controller', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Access_controllers"
    unless params[:access_controller_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'access_controller')
      redirect(url(:access_controllers, :index))
    end
    ids = params[:access_controller_ids].split(',').map(&:strip)
    access_controllers = AccessController.find(ids)
    
    if access_controllers.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Access_controllers', :ids => "#{ids.join(', ')}")
    end
    redirect url(:access_controllers, :index)
  end
end
