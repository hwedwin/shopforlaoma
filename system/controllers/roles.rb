Myblog::System.controllers :roles do

  layout :app

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
    @roles = Role.all
    render 'roles/index'
  end

  get :show do

  end

  post :create do

  end

  post :update do

  end

  get :new do
    render 'roles/new'
  end

  get :edit do

  end

end
