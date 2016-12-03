<!DOCTYPE html>
<html><head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport"
		content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta name="renderer" content="webkit">
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<title>金莱蒂后台管理</title>

	<!-- Set render engine for 360 browser -->
	<meta name="renderer" content="webkit">

	<!-- No Baidu Siteapp-->
	<meta http-equiv="Cache-Control" content="no-siteapp"/>

	<link rel="icon" type="image/png" href="/images/logoP.png">

	<!-- Add to homescreen for Chrome on Android -->
	<meta name="mobile-web-app-capable" content="yes">
	<link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">

	<!-- Add to homescreen for Safari on iOS -->
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-title" content="金莱蒂"/>
	<link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">

	<!-- Tile icon for Win8 (144x144 + tile color) -->
	<meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
	<meta name="msapplication-TileColor" content="#0e90d2">
	<?php echo Asset::css('semantic.min.css'); ?>
	<?php echo Asset::js('jquery.min.js'); ?>
  <?php echo Asset::js('semantic.min.js'); ?>
	<?php echo Asset::js('enquire.min.js'); ?>

  <style type="text/css">
    body {
      background-color: #DADADA;
    }
    body > .grid {
      height: 100%;
    }
    .image {
      margin-top: -100px;
    }
    .column {
      max-width: 450px;
    }
  </style>
  <script>
  $(document)
    .ready(function() {
      $('.ui.form')
        .form({
          fields: {
            email: {
              identifier  : 'email',
              rules: [
                {
                  type   : 'empty',
                  prompt : 'Please enter your e-mail'
                },
                {
                  type   : 'email',
                  prompt : 'Please enter a valid e-mail'
                }
              ]
            },
            password: {
              identifier  : 'password',
              rules: [
                {
                  type   : 'empty',
                  prompt : 'Please enter your password'
                },
                {
                  type   : 'length[6]',
                  prompt : 'Your password must be at least 6 characters'
                }
              ]
            }
          }
        })
      ;
    })
  ;
  </script>
</head>
<body data-feedly-mini="yes">

<div class="ui middle aligned center aligned grid">
  <div class="column">
    <h2 class="ui teal image header">
      <img src="/images/logo.png" class="small image">
      <div class="content">
        登录金莱蒂后台管理系统
      </div>
    </h2>
		<div class="twelve wide  center aligned padding column">
			<?php if (Session::get_flash('success')): ?>
						<div class="ui positive message">
							<i class="close icon"></i>
							<strong>成功</strong>
							<p>
							<?php echo implode('</p><p>', e((array) Session::get_flash('success'))); ?>
							</p>
						</div>
			<?php endif; ?>
			<?php if (Session::get_flash('error')): ?>
						<div class="ui negative message">
							<i class="close icon"></i>
							<strong>错误</strong>
							<p>
							<?php echo implode('</p><p>', e((array) Session::get_flash('error'))); ?>
							</p>
						</div>
			<?php endif; ?>
			<?php echo Form::open(array("class"=>"ui large form")); ?>
      <div class="ui stacked segment">
        <div class="field">
          <div class="ui left icon input">
            <i class="user icon"></i>
            <input type="text" name="name" placeholder="用户名">
          </div>
        </div>
        <div class="field">
          <div class="ui left icon input">
            <i class="lock icon"></i>
            <input type="password" name="pass" placeholder="密码">
          </div>
        </div>
        <div class="ui fluid large teal submit button">登录</div>
      </div>

      <div class="ui error message"></div>

      <?php echo Form::close(); ?>


  </div>
</div>

</body>
</html>
