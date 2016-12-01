Myblog::App.controllers :login do
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
    if current_user
      redirect url(:personal, :index)
    end
  end

  post :index do
    @message = ''
    @user = User.where(mobile: params[:mobile]).first
    if @user
      if session[:valid]==params[:smstext]
          set_current_user(@user)
      else
        @message = '验证码错误！'
        redirect url(:login, :index), :error => @message.html_safe+'<i class="close icon"></i>'.html_safe
      end

    else
      if session[:valid]==params[:smstext]
        @user = User.new
        @user.mobile = params[:mobile];
        @user.username = params[:mobile];
        @user.password = params[:smstext];
        @user.password_confirmation = params[:smstext];
        @user.save
        set_current_user(@user)
      else
        @message = '验证码错误！'
        render 'login/index'
        return nil
      end

    end
    if session[:is_from_share]
      session[:is_from_share] = false
      @product_id = session[:product_id]
      session[:product_id] = nil
      redirect url(:products, :index, :id => @product_id)
    end
    if session[:intend_to_buy]
      session[:intend_to_buy] = false
      @product_id = session[:product_id]
      session[:product_id] = nil
      redirect url('/order/'+@product_id)

    end
    redirect url(:personal, :index)
  end

  get :index do

    render 'login/index'
  end

  get :out do
    destroy_current_user
    redirect url(:login, :index)
  end

  get :term do
    render 'login/term'
  end


  get :sms do

    session[:valid] = rand(9).to_s+rand(9).to_s+rand(9).to_s+rand(9).to_s
    sms_param = {
      "valid": session[:valid],
      "name": "用户"
    }
    mobile = params[:mobile]
    #调用php的sdk验证
    result = post_sms('http://localhost:8080/sms.php',{
      sms_param: sms_param.to_json,
      rec_num: mobile
      });


  end

  get :removeSms do
    session[:valid] = nil
  end

end
