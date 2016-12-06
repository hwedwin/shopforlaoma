Myblog::System.controllers :login do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end
  layout :login



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
    if current_admin
      redirect url('/')
    end
  end

  get :index do
    render 'login/index'
  end

  post :index do
    @message = ''
    @admin = User.where(mobile: params[:mobile]).first
    if @admin
      if session[:valid]==params[:smstext]
          if @admin.is_seller or @admin.is_super
            set_current_admin(@admin)
          else
            @message = '您没有权限访问系统'
            redirect url(:login, :index), :error => @message.html_safe+'<i class="close icon"></i>'.html_safe
          end


      else
        @message = '验证码错误！'
        redirect url(:login, :index), :error => @message.html_safe+'<i class="close icon"></i>'.html_safe
      end

    else
        @message = '用户不存在！'
        redirect url(:login, :index), :error => @message.html_safe+'<i class="close icon"></i>'.html_safe
    end

    redirect url('/')
  end

  get :out do
    destroy_current_admin
    redirect url('/')
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
