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
    {{ javascript_include('js/ajaxfileupload.js') }}
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

    function fileUpload(fileInput,url){
        var logo = document.getElementById('logo');
        var logoImg = document.getElementById('logoImg');
        var prefix = Math.random()*10000 | 0 , suffix = Math.random()*10000 | 0 , time = new Date().getTime();
        $.ajaxFileUpload({
            url:url,
            secureuri:false,
            fileElementId:fileInput,
            dataType: 'json',
            data:{prefix:prefix , suffix:suffix , time:time},
            success: function (data){     
                logoImg.src = logo.value = "http://121.40.134.209:291/./toolbar/img/"+prefix+time+suffix+'.jpg';
            },
            error: function (data,status,e){
                logoImg.src = logo.value = "http://121.40.134.209:291/./toolbar/img/"+prefix+time+suffix+'.jpg';
            }
        })
    }

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
                        <a href="javascript:;" class="selected">修改频道</a>
                    </li>
                </ul>
            </div>

            <div id="tab1" class="tabson">
                {{ form('nav/doit','enctype':'multipart/form-data') }}
                <input type="hidden" name="id" value="{{ nav.id }}" />
                <ul class="forminfo">
                {% if this.session.get('user')['provinceid'] == 0 %}
                <li>
                    <label>选择地域</label>

                    <div class="usercity">

                        <div class="cityleft">
                            
                            {{ select("provinceid",provinces,'using': ['provinceid', 'province'],"value" : nav.provinceid,"class":"select2")}}
                            </select>
                        </div>

                    </div>
                </li>
                {% endif %}
                {% if nav.type == 2 %}

                    <li>
                        <label>
                            上传logo
                            <b>*</b>
                        </label>

                        <input id="fileInput" type="file" name="upload" onchange="fileUpload('fileInput','http://121.40.134.209:291/upload.php')">
                        <input type="hidden" name="name" id="logo" value="{{ nav.name }}"></li>
                        <input type="hidden" name="type" value="2">
                    </li>
                    <li>
                        <label>&nbsp;</label>
                        <img src="{{ nav.name }}" id="logoImg" alt="请上传图片" style="max-width:100px;">
                    </li>
                {% else %}
                    <li>
                        <label>
                            频道名称 <b>*</b>
                        </label>
                        <input name="name" type="text" value="{{ nav.name }}" class="dfinput"  style="width:518px;" required/>
                        <input type="hidden" name="type" value="1">
                    </li>
                {% endif %}

                <li>
                    <label>
                        频道标题 <b>*</b>
                    </label>
                    <input name="desc" type="text" value="{{ nav.desc }}" class="dfinput"  style="width:518px;" required/>
                </li>

                
                <li>
                    <label>
                        选择模板 <b>*</b>
                    </label>
                    <div class="cityright">
                            <select class="select2"  name="tmpl">
                                {% for k,v in tmpl %}
                                    <option value="{{ k }}" {% if k == nav.tmpl %} selected {% endif %}>{{ v }}</option>
                                {% endfor %}
                            </select>
                        </div>
                </li>

                <li>
                    <label>
                        排序
                        <b>*</b>
                    </label>

                    <input type="number" value="{{ nav.ord }}"  name="ord" class="dfinput"></li>

                <li>
                    <label>&nbsp;</label>
                    <input type="submit" class="btn" value="确　认"/>
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