<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    {{ assets.outputCss() }}
    {{ assets.outputJs() }}
    
    <script type="text/javascript">
$(function(){   
    //顶部导航切换
    $(".nav li a").click(function(){
        $(".nav li a.selected").removeClass("selected")
        $(this).addClass("selected");
    })  
})  
</script>

</head>

<body style="background:url({{ url('images/topbg.gif') }}) repeat-x;">

    <div class="topleft">
        <a href="{{ url('main/index') }}" target="_parent">
            {{ image('images/logo.png') }}"
        </a>
    </div>

    <ul class="nav">
        <li>
            <a href="{{ url('main/right') }}" target="rightFrame" class="selected">
                {{ image('images/icon01.png') }}
                <h2>首页</h2>
            </a>
        </li>
        <li>
            <a href="{{ url('Stat/index') }}" target="rightFrame">
                {{ image('images/icon02.png') }}
                <h2>数据管理</h2>
            </a>
        </li>
        <li>
            <a href="{{ url('nav/index') }}"  target="rightFrame">
                {{ image('images/icon03.png') }}
                <h2>频道管理</h2>
            </a>
        </li>
        <li>
            <a href="{{ url('verify/index') }}"  target="rightFrame">
                {{ image('images/icon04.png') }}
                <h2>数据审核</h2>
            </a>
        </li>

        <li>
            <a href="{{ url('user/index') }}"  target="rightFrame">
                {{ image('images/icon06.png') }}
                <h2>用户管理</h2>
            </a>
        </li>
    </ul>

    <div class="topright">
        <ul>
            <li>
                <span>
                    {{ image('images/help.png') }}
                </span>
                <a href="#">帮助</a>
            </li>
            <li>
                <a href="#">关于</a>
            </li>
            <li>
                <a href="{{url('login/logout')}}" target="_parent">退出</a>
            </li>
        </ul>

        <div class="user">
            <span> {{session.get('user')['email']}} </span>
        </div>

    </div>

</body>
</html>