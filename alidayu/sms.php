<?php
  include "TopSdk.php";
  date_default_timezone_set('Asia/Shanghai');



  $appkey = '23538990';
  $secret = '9632728898f7ac33a90afd2055208482';
  $c = new TopClient;
  $c->appkey = $appkey;
  $c->secretKey = $secret;
  $c->format= "json";
  $req = new AlibabaAliqinFcSmsNumSendRequest;
  $req->setExtend("123456");
  $req->setSmsType("normal");
  $req->setSmsFreeSignName("老猫商城");
  // $req->setSmsParam($_POST["sms_param"]);
  $req.setSmsParamString("{\"valid\":\"1234\",\"name\":\"alidayu\"}");
  // $req->setRecNum($_POST["rec_num"]);
  $req->setRecNum('18781621212');
  $req->setSmsTemplateCode("SMS_27665222");
  $resp = $c->execute($req);
  var_dump($resp);
 ?>
