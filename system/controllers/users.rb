Myblog::System.controllers :users do

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

  get :index do
    @users = User.all
    render 'users/index'
  end

  get :edit do

  end

  post :update do

  end

  get :disable_seller, :with => :id do
    @user = User.find(params[:id])
    @user.is_seller = false
    if @user.save
      1.to_s
    else
      0.to_s
    end
  end

  get :enable_seller, :with => :id do
    @user = User.find(params[:id])
    @user.is_seller = true
    if @user.save
      1.to_s
    else
      0.to_s
    end

  end

  get :disable_super, :with => :id do
    @user = User.find(params[:id])
    @user.is_super = false
    if @user.save
      1.to_s
    else
      0.to_s
    end

  end

  get :enable_super, :with => :id do
    @user = User.find(params[:id])
    @user.is_super = true
    if @user.save
      1.to_s
    else
      0.to_s
    end

  end

end
