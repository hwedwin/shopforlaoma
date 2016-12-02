Myblog::App.controllers :personal do


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

  before :index do
    if !current_user
      redirect url(:login, :index)
    end
  end

  get :index do
    if current_user.balance
      @balance = current_user.balance
    else
      @balance = Balance.new
      @balance.currency_big = 0;
      @balance.currency_small = 0;
      @balance.amount = '0.00';
      current_user.balance = @balance;
      @balance.save
    end
    if @balance.bills
      @bills = @balance.bills
    else
      @bills = []
    end
    if current_user.orders
      @orders = current_user.orders
    else
      @orders = []

    end
    render 'personal/index'
  end

  post :update , :provides => :js do
    render :erb, 'personal/update.js'
  end

end
