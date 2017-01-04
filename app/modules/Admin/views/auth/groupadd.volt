<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/select.css" rel="stylesheet" type="text/css" />
    {{ assets.outputCss() }}

    {{ assets.outputJs() }}
    
    <style>
        .checkdiv{
            float:left;
            width:150px;
            height:30px;
        }
    </style>

</head>

<body>

    <div class="place">
        <span>位置：</span>
        <ul class="placeul">
            <li>
                <a href="#">首页</a>
            </li>
            <li>
                <a href="#">权限控制</a>
            </li>
        </ul>
    </div>

    <div class="formbody">

        <div id="usual1" class="usual">

            <div class="itab">
                <ul>
                    <li>
                        <a href="javascript:;" class="selected">添加权限组</a>
                    </li>
                </ul>
            </div>

            <div id="tab1" class="tabson">
                {{ form('auth/groupinsert') }}
                <ul class="forminfo">               
                
                <li>
                    <label>
                        权限组名称 <b>*</b>
                    </label>
                    <input name="title" type="text" class="dfinput"  style="width:518px;" required/>
                    
                </li>


                <li>


                    <label>
                        权限选择 
                    </label>
                    <div style="float:left;width:750px;">
                        {% for rule in rules %}
                            <div class="checkdiv">
                                <input type="checkbox" class="uniform_on" name="ids[]" value="{{ rule.id }}" /> {{ rule.title }}
                            </div>                            
                        {% endfor %}
                    </div>                    
                </li>
                <li>
                    <label>　</label>
                    <label><input type="checkbox" class="uniform_on" id="checkall" />全选</label>
                    <label>
                        <input type="checkbox" class="uniform_on" id="opposite"  />反选
                    </label>　　                    

                </li>
                
                

                <li>
                    <label>&nbsp;</label>
                    <input type="submit" class="btn" value="添　加"/>
                </li>
            </ul>
        </form>

    </div>

</div>


</div>

</body>
<script>
    var checkall = document.getElementById('checkall');
    var opposite = document.getElementById('opposite');
    var ids = document.getElementsByName('ids[]');

    checkall.onclick = function(){        
        for(var i = 0 ; i < ids.length ; i++){
            ids[i].checked = checkall.checked;
        }
    }

    opposite.onclick = function (){
        for(var i = 0 ; i < ids.length ; i++){
            ids[i].checked = !ids[i].checked;
        }
    }
</script>
</html>