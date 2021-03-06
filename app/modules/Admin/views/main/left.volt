<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    {{ assets.outputCss() }}
    {{ assets.outputJs() }}
    <script type="text/javascript">
$(function(){   
    //导航切换
    $(".menuson .header").click(function(){
        var $parent = $(this).parent();
        $(".menuson>li.active").not($parent).removeClass("active open").find('.sub-menus').hide();
        
        $parent.addClass("active");
        if(!!$(this).next('.sub-menus').size()){
            if($parent.hasClass("open")){
                $parent.removeClass("open").find('.sub-menus').hide();
            }else{
                $parent.addClass("open").find('.sub-menus').show(); 
            }
            
            
        }
    });
    
    // 三级菜单点击
    $('.sub-menus li').click(function(e) {
        $(".sub-menus li.active").removeClass("active")
        $(this).addClass("active");
    });
    
    $('.title').click(function(){
        var $ul = $(this).next('ul');
        $('dd').find('.menuson').slideUp();
        if($ul.is(':visible')){
            $(this).next('.menuson').slideUp();
        }else{
            $(this).next('.menuson').slideDown();
        }
    });
})  
</script>

</head>

<body style="background:#fff3e1;">
    <div class="lefttop">
        <span></span>
        ToolBar管理
    </div>

    <dl class="leftmenu">
    {% if acl.isAllowed(session.get('user')['auth'] , 'Content' , 'index') %}
        <dd>
            
            <div class="title">
                <span>
                    {{ image("images/leftico01.png") }}
                </span>
                数据管理
            </div>
            <ul class="menuson">

                <li class="active">
                    <div class="header">
                        <cite></cite>
                        <a href="{{ url('main/right') }}" target="rightFrame">首页</a> <i></i>
                    </div>
                    
                </li>

                <li>
                    <div class="header">
                        <cite></cite>
                        <a href="javascript:;" target="rightFrame">数据列表</a> <i></i>
                    </div>
                    <ul class="sub-menus">
                    {% for v in channel %}
                        <li>
                            <a href="{{ url('content/index') }}?nid={{ v.id }}" target="rightFrame">{{ v.name }}</a>

                        </li>                        
                    {% endfor %}
                    </ul>
                </li>
                
                <li>
                    <div class="header">
                        <cite></cite>
                        <a href="javascript:;" target="rightFrame">添加数据</a> <i></i>
                    </div>
                    <ul class="sub-menus">
                    {% for v in channel %}
                        <li>
                            <a href="{{ url('content/add') }}?nid={{ v.id }}" target="rightFrame">{{ v.name }}</a>

                        </li>                        
                    {% endfor %}
                    </ul>
                </li>
               
            </ul>
        </dd>
    {% endif %}
    {% if acl.isAllowed(session.get('user')['auth'] , 'Nav' , 'index') %}
        <dd>
            <div class="title">
                <span>
                    {{ image("images/leftico02.png") }}
                </span>
                频道管理
            </div>
            <ul class="menuson">
                <li>
                    

                    <div class="header">
                        <cite></cite>
                        <a href="{{ url('nav/index') }}" target="rightFrame">频道列表</a> <i></i>
                    </div>
                    
                </li>
                <li>
                    <div class="header">
                        <cite></cite>
                        <a href="{{ url('nav/add') }}?showType=1" target="rightFrame">添加频道</a> <i></i>
                    </div>
                    <ul class="sub-menus">
                    
                        <li>
                            <a href="{{ url('nav/add') }}?showType=1" target="rightFrame">文字</a>
                        </li>
                        <li>
                            <a href="{{ url('nav/add') }}?showType=2" target="rightFrame">图片</a>
                        </li>
                    </ul>
                </li>
                
            </ul>
        </dd>
    {% endif %}
    {% if acl.isAllowed(session.get('user')['auth'] , 'User' , 'index') %}
        <dd>
            <div class="title">
                <span>
                    {{ image("images/leftico03.png") }}
                </span>
                用户管理
            </div>
            <ul class="menuson">
                <li>
                    <cite></cite>
                    <a href="{{ url('user/index') }}" target="rightFrame">用户列表</a>
                    <i></i>
                </li>
                <li>
                    <cite></cite>
                    <a href="{{ url('user/add') }}" target="rightFrame">添加用户</a>
                    <i></i>
                </li>
                
            </ul>
        </dd>
    {% endif %}
    {% if acl.isAllowed(session.get('user')['auth'] , 'Auth' , 'index') %}
        <dd>
            <div class="title">
                <span>
                    {{ image("images/leftico04.png") }}
                </span>
                权限管理
            </div>
            <ul class="menuson">
                <li>
                    <cite></cite>
                    <a href="{{ url('auth/index') }}" target="rightFrame">权限组列表</a>
                    <i></i>
                </li>
                <li>
                    <cite></cite>
                    <a href="{{ url('auth/groupadd') }}" target="rightFrame">添加权限组</a>
                    <i></i>
                </li>
                <li>
                    <cite></cite>
                    <a href="{{ url('auth/rule') }}" target="rightFrame">权限规则列表</a>
                    <i></i>
                </li>
                <li>
                    <cite></cite>
                    <a href="{{ url('auth/ruleadd') }}" target="rightFrame">添加权限规则</a>
                    <i></i>
                </li>
                
            </ul>
        </dd>
    {% endif %}
    {% if acl.isAllowed(session.get('user')['auth'] , 'Verify' , 'index') %}
        <dd>
            <div class="title">
                <span>
                    {{ image("images/leftico04.png") }}
                </span>
                数据审核
            </div>
            <ul class="menuson">
                <li>
                    <cite></cite>
                    <a href="{{ url('verify/index') }}" target="rightFrame">数据列表</a>
                    <i></i>
                </li>
                
            </ul>

        </dd>
    {% endif %}
    </dl>

</body>
</html>