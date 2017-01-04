<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>欢迎登录后台管理系统</title>
    {{ stylesheet_link('css/style.css') }}
    {{ javascript_include('js/jquery.js') }}
    {{ javascript_include('js/cloud.js') }}
    <script language="javascript">
    $(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    $(window).resize(function(){  
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    })  
});  
</script>

</head>

<body style="background-color:#df7611; background-image:url({{ url('images/light.png') }}); background-repeat:no-repeat; background-position:center top; overflow:hidden;">

    <div id="mainBody">
        <div id="cloud1" class="cloud"></div>
        <div id="cloud2" class="cloud"></div>
    </div>

    <div class="logintop">
        <span>欢迎登录后台管理界面平台</span>
        <ul>
            <li>
                <a href="#">回首页</a>
            </li>
            <li>
                <a href="#">帮助</a>
            </li>
            <li>
                <a href="#">关于</a>
            </li>
        </ul>
    </div>

    <div class="loginbody">

        <span class="systemlogo"></span>

        <div class="loginbox">
            <form action="{{ url('login/check') }}" method="post">
                <ul>
                    <li>
                        <input name="email" type="email" {% if user is defined %} value=" {{ user.email }} " {% endif %} class="loginuser" placeholder="邮箱"/>
                    </li>
                    <li>
                        <input name="password" type="password" class="loginpwd" {% if user is defined %} value="{{ user.password }}" {% endif %} placeholder="密码"/>
                    </li>
                    <li>
                        <input name="" type="submit" class="loginbtn" value="登录"    />
                        <label>
                            <input name="remember_me" type="checkbox"  checked="checked" />
                            记住密码
                        </label>
                        <label>
                            <a href="#">忘记密码？</a>
                        </label>
                    </li>
                </ul>
            </form>

        </div>

    </div>

    <div class="loginbm">
        版权所有  2014
        <a href="http://www.uimaker.com">uimaker.com</a>
        仅供学习交流，勿用于任何商业用途
    </div>

</body>

</html>