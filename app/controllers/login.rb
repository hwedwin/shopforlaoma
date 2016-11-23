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
    require 'digest'
    app_key = '23538990'
    _format = 'json'
    method = 'alibaba.aliqin.fc.sms.num.send'
    rec_num = '18820965455'
    sign_method = 'md5'
    sms_free_sign_name = '老猫商城'
    sms_param = {
      'valid': "1234",
      'name': 'simon'
    }
    sms_template_code = 'SMS_27665222'
    sms_type = 'normal'
    timestamp = DateTime.parse(Time.now.to_s).strftime('%Y-%m-%d %H:%M:%S').to_s
    v = '2.0'

    sign_ready = 'app_key'+app_key+'format'+_format+'method'+method
    +'rec_num'+rec_num+'sign_method'+sign_method+'sms_free_sign_name'+
    sms_free_sign_name+'sms_param'+sms_param.to_json+'sms_template_code'+
    sms_template_code+'sms_type'+sms_type+'timestamp'+timestamp+
    'v'+v
    api_secret = '9632728898f7ac33a90afd2055208482'
    sign_ready = api_secret + sign_ready + api_secret

    md5 = Digest::MD5.new
    md5.update sign_ready
    sign = md5.hexdigest

    params = {
      'method' => 'alibaba.aliqin.fc.sms.num.send',
      'app_key' => '23538990',
      'sign_method' => 'md5',
      'sign' => sign,
      'timestamp' => DateTime.parse(Time.now.to_s).strftime('%Y-%m-%d %H:%M:%S').to_s,
      'format' => 'json',
      'sms_type' => 'normal',
      'sms_free_sign_name' => '老猫商城',
      'v' => '2.0',
      'sms_param' => {
        'valid': "1234",
        'name': 'simon'
      },
      'rec_num' => '18820965455',
      'sms_template_code' => 'SMS_27665222'

    }

    post_sms('http://gw.api.taobao.com/router/rest',params)

  end

end
