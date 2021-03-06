<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/select.css" rel="stylesheet" type="text/css" />
    {{ assets.outputCss() }}
    {{ stylesheet_link('css/select.css') }}
    {{ assets.outputJs() }}
    {{ javascript_include('js/jquery.idTabs.min.js') }}
    {{ javascript_include('js/select-ui.min.js') }}
    <script type="text/javascript">
$(document).ready(function(e) {
    $(".select1").uedSelect({
        width : 345           
    });
    $(".select2").uedSelect({
        width : 167  
    });
    $(".select3").uedSelect({
        width : 100
    });
});
</script>
</head>

<body>

    <div class="place">
        <span>位置：</span>
        <ul class="placeul">
            <li>
                <a href="#">首页</a>
            </li>
            <li>
                <a href="#">系统设置</a>
            </li>
        </ul>
    </div>

    <div class="formbody">

        <div id="usual1" class="usual">

            <div class="itab">
                <ul>
                    <li>
                        <a href="javascript:;" class="selected">添加用户</a>
                    </li>
                </ul>
            </div>

            <div id="tab1" class="tabson">
                {{ form('user/insert','enctype':'multipart/form-data') }}
                <ul class="forminfo">
                    <li>
                        <label>
                            用户邮箱 <b>*</b>
                        </label>
                        <input name="email" type="Email" class="dfinput"  style="width:518px;" required/>
                    </li>
                    <li>
                        <label>
                            用户密码 <b>*</b>
                        </label>
                        <input name="password" type="password" class="dfinput"  style="width:518px;" required/>
                    </li>
                    <li>
                        <label>用户权限</label>
                        <div class="usercity">

                            <div class="cityleft">
                                {{ select("auth",auth,'using': ['id', 'title'], 'useEmpty':true,'emptyText':'不限','emptyValue':"0" , "class":"select2") }}
                                </select>
                            </div>

                        </div>
                        
                    </li>

                    <li>
                        <label>
                            用户昵称
                            
                        </label>
                        <input name="name" type="text" class="dfinput"  style="width:518px;" />
                    </li>

                    <li>
                        <label>
                            地域
                            
                        </label>
                        <div class="cityright">
                            <select class="select2"  name="provinceid">
                                {% for province in provinces %}
                                <option value="{{ province.provinceid }}"  >{{ province.province }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </li>

                    <li>
                        <label>
                            用户手机
                            
                        </label>
                        <input name="phone" type="text" class="dfinput"  style="width:518px;" />
                    </li>

                    <li>
                        <label>
                            公司
                            
                        </label>
                        <input name="company" type="text" class="dfinput"  style="width:518px;" />
                    </li>

                    <li>
                        <label>
                            用户地址
                            
                        </label>
                        <input name="addr" type="text" class="dfinput"  style="width:518px;" />
                    </li>


                    <li>
                        <label>&nbsp;</label>
                        <input type="submit" class="btn" value="添　加"/>
                    </li>
                </ul>
            </form>

        </div>

    </div>

    <script type="text/javascript">$("#usual1 ul").idTabs(); </script>

    <script type="text/javascript">$('.tablelist tbody tr:odd').addClass('odd');</script>

</div>

</body>

</html>