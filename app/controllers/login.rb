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
    @user = {
      name: "username",
      pass: "cryptedpass",
      mobile: "18820965455"
    }
    set_current_user(@user)
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

    session[:valid] = rand(9999).to_s
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
