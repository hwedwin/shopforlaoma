Myblog::App.controllers :products do

  layout :homepage

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
    @products_active = "active"
    @products = Product.all
    @node = get_current_node
    render 'products/index'
  end


  get :session_out do
    session.clear
  end

  get :index, :with => :id do
    if Product.where(id: params[:id]).exists?
        @product = Product.find(params[:id])
    else
        @product = Product.first
    end


    render 'products/product'
  end

  get :insurance do

  end

  get :insurance, :with => :id do
    @products = 'active'
    '保险'
  end

  get :car do

  end

  get :car_using do

  end

end
