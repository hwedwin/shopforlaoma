Myblog::System.controllers :products do
  layout :app
  enable :sessions
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
    @products = Product.all
    render 'products/index'
  end

  get :new do
    #使用类变量来进行数据保持
    if Product.get_new_product == 0
      @new_product = Product.set_new_product(Product.new)
    else
      @new_product = Product.get_new_product
    end

     render 'products/new'
  end

  post :create_product_category do
    @new_product = Product.get_new_product
    @new_product.category = params[:category]
    Product.set_new_product(@new_product)
    redirect url(:products, :new_step_two)

  end

  get :new_step_two do
    if Product.get_new_product == 0
      @new_product = Product.new
      @new_product = Product.set_new_product(Product.new)
    else
      @new_product = Product.get_new_product
    end
    if @new_product.category
      if @new_product.category.name == '汽车'
        render 'products/new_step_two_car'
      else

      end
    else
      redirect url(:products, :new)
    end

  end

  post :create_car_info do
    if Product.get_new_product == 0
      @new_product = Product.new
      @new_product = Product.set_new_product(Product.new)
    else
      @new_product = Product.get_new_product
    end
    @new_product = Product.get_new_product
    @new_product.cover = params[:cover]
    @new_product.brand = params[:brand]
    @new_product.product_model_type = params[:product_model_type]
    # session[:new_product].save

    @car = Car.new(params[:car])

    @car.model_type = params[:product_model_type]

    @new_product.car = @car

    Product.set_new_product(@new_product)

    redirect url(:products, :new_step_three_car)
  end


  get :session do
    session[:new_product].to_json
  end

  get :delete_s do
    session.clear
  end


  get :new_step_three_car do
    @title = "确认车辆基本信息"
    if Product.get_new_product == 0
      @new_product = Product.new
      @new_product = Product.set_new_product(Product.new)
    else
      @new_product = Product.get_new_product
    end
    if @new_product.category
      if @new_product.category.name == '汽车'
        render 'products/new_step_three_car'
      else

      end
    else
      redirect url(:products, :new)
    end

  end

  post :create_product_pictures do
    params[:pictures].each do |picture|
      @new_product.pictures.push(picture)
    end
    redirect url(:products, :new_step_four)
  end

  get :save_new_product_car do
    Product.get_new_product.save
    Product.set_new_product(0)
    redirect url(:products, :index)
  end

  get :new_step_four do
    render 'product/new_step_four'
  end

  get :edit do

  end

  get :new do

  end

  post :create do

  end

  post :update do

  end

end
