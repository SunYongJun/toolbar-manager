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
{{ javascript_include('kindeditor/kindeditor-min.js') }}
<style>
    .fl{
        float: left;
    }
    .mr10{
        margin-right:10px; 
    }
</style>
    <script type="text/javascript">
    var editor;
    KindEditor.ready(function(K) {
        editor = K.create('textarea[id="content7"]', {
            allowFileManager : true
        });
    })
  </script>

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

    $(document).ready(function(){
        var upEditor;

        $(".click").click(function(){        
            $('#upContent').val($(this).parent().prev('input').val());
            $('#upContent').attr('name',$(this).parent().prev('input').attr('name'));
            upEditor = KindEditor.create('textarea[id="upContent"]', {
                        resizeType : 1,
                        allowPreviewEmoticons : false,
                        allowImageUpload : false,
                        items : [
                            'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
                            'removeformat']
                    });    

            $(".tip").fadeIn(200);
        });
      
        $(".tiptop a").click(function(){        
            $(".tip").fadeOut(200);
            KindEditor.remove('textarea[id="upContent"]');
        });

        $(".sure").click(function(){
            $(".tip").fadeOut(100);
            $('input[name="'+$('#upContent').attr('name')+'"]').val(upEditor.html());
            KindEditor.remove('textarea[id="upContent"]');
        });

        $(".cancel").click(function(){
            $(".tip").fadeOut(100);
            KindEditor.remove('textarea[id="upContent"]');
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
                        <a href="javascript:;" class="selected">{{ channel.name }}</a>
                    </li>
                </ul>
            </div>

            <div id="tab1" class="tabson">
                {{ form('content/insert','enctype':'multipart/form-data') }}
                <ul class="forminfo">

                <li>
                    <label>选择地域</label>

                    <div class="usercity">

                        <div class="cityleft">
                            {{ select("cityid",cities,'using': ['cityid', 'city'],'useEmpty':true,'emptyText':'不限','emptyValue':0,"class":"select2")}}
                            </select>
                        </div>

                    </div>
                </li>

                <input type="hidden" name="nid" value="{{ this.request.get('nid') }}" />   
                {% if channel.tmpl == 0 or channel.tmpl == 1 %}
                <li>
                    <label>
                        标题 <b>*</b>
                    </label>
                    <input name="title" type="text" class="dfinput fl mr10"  style="width:518px;" required/>
                    <ul class="toolbar">
                        <li class="click"><span>{{ image('images/t02.png') }}</span>修改样式</li>
                    </ul>
                </li>

                <li>
                    <label>
                        内容 <b>*</b>
                    </label>
                    <input name="contents" type="text" class="dfinput fl mr10"  style="width:518px;" required/>
                    <ul class="toolbar">
                        <li class="click"><span>{{ image('images/t02.png') }}</span>修改样式</li>
                    </ul>
                </li>

                <li>
                    <label>
                        按钮
                        <b>*</b>
                    </label>
                    <input name="linkname" type="text" class="dfinput fl mr10"  style="width:518px;" required/>
                    <ul class="toolbar">
                        <li class="click"><span>{{ image('images/t02.png') }}</span>修改样式</li>
                    </ul>
                </li>

                <li>
                    <label>
                        URL
                        <b>*</b>
                    </label>
                    <input name="url" type="url" class="dfinput"  style="width:518px;" required/>
                </li>
                {% elseif channel.tmpl == 2 %}
                <li>
                    <label>
                        上传logo
                        <b>*</b>
                    </label>

                    <input id="fileInput" type="file" name="upload" onchange="fileUpload('fileInput','http://121.40.134.209:291/upload.php')">
                    <input type="hidden" name="logo" id="logo" value=""></li>

                <li>
                    <label>&nbsp;</label>
                    <img src="{{ url() }}/public/images/ico04.png" id="logoImg" alt="请上传logo" />
                </li>

                <li>
                    <label>
                        网站名称
                        <b>*</b>
                    </label>
                    <input name="title" type="text" class="dfinput"  style="width:518px;" required/>
                </li>

                <li>
                    <label>
                        URL
                        <b>*</b>
                    </label>
                    <input name="url" type="url" class="dfinput"  style="width:518px;" required/>
                </li>
                {% elseif channel.tmpl == 3 %}
                <li>
                    <label>
                        活动名称
                        <b>*</b>
                    </label>
                    <input name="title" type="text" class="dfinput"  style="width:518px;" required/>
                </li>

                <li>
                    <label>
                        上传图片
                        <b>*</b>
                    </label>

                    <input id="fileInput" type="file" name="upload" onchange="fileUpload('fileInput','http://121.40.134.209:291/upload.php')">
                    <input type="hidden" name="logo" id="logo" value=""></li>

                <li>
                    <label></label>
                    <img src="{{ url() }}/public/images/ico04.png" id="logoImg" alt="请上传logo" />
                </li>

                <li>
                    <label>
                        URL
                        <b>*</b>
                    </label>
                    <input name="url" type="url" class="dfinput"  style="width:518px;" required/>
                </li>
                {% elseif channel.tmpl == 5 %}
                <li>
                    <label>
                        编辑
                        <b>*</b>
                    </label>

                    <textarea id="content7" name="contents" style="width:700px;height:250px;visibility:hidden;"></textarea>

                </li>
                {% elseif channel.tmpl == 6 %}
                <li>
                    <label>
                        HTML代码
                        <b>*</b>
                    </label>

                    <textarea name="contents" class="textarea_compact"></textarea>

                </li>
                {% endif %}
                <li>
                    <label>
                        排序
                        <b>*</b>
                    </label>

                    <input type="number"   name="ord" class="dfinput"></li>

                <li>
                    <label>&nbsp;</label>
                    <input type="submit" class="btn" value="添　加"/>
                </li>
            </ul>
        </form>

    </div>

</div>
<div class="tip">
    <div class="tiptop"><span>提示信息</span><a></a></div>
    <div>
        <textarea name="upContent" id="upContent" style="width:280px;height:200px;"></textarea>
    </div>
    <div class="tipbtn">
        <input name="" type="button"  class="sure" value="确定" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
    </div>
</div>
<script type="text/javascript">$("#usual1 ul").idTabs(); </script>

<script type="text/javascript">$('.tablelist tbody tr:odd').addClass('odd');</script>

</div>
<script>


        /*function getOptions(nOptions,selectId){
            var s = document.getElementById(selectId) , sh=s.length;
            var i = 0;
            s.options[i] = new Option('不限',0);i++;
            for(k in nOptions){
                s.options[i] = new Option(nOptions[k],k);
                i++;
            }
            if(i<sh){
                for(var n = sh-1; n >= i; n--){
                    s.options[n] = null;
                }
            }
        }
        $('#cityid').change(function(){
            $.post('getArea',{ cityid:$(this).val() } , function(data){
                $('#city').val(0);
                $('.cityright .uew-select-text').html('不限');
                getOptions(eval("("+data+")"),'areaid');
            })
            $('#city').val($(this).children("option[value='"+$(this).val()+"']").html());
        })

        $('#areaid').change(function(){
            $('#area').val($(this).children("option[value='"+$(this).val()+"']").html());
        })*/

    </script>
</body>

</html>