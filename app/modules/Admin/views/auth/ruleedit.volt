<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/select.css" rel="stylesheet" type="text/css" />
    {{ assets.outputCss() }}

    {{ assets.outputJs() }}


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
                        <a href="javascript:;" class="selected">添加权限规则</a>
                    </li>
                </ul>
            </div>

            <div id="tab1" class="tabson">
                {{ form('auth/ruledoit') }}
                <ul class="forminfo">               
                <input type="hidden" name="id" value="{{ rule.id }}" />
                <li>
                    <label>
                        控制器 <b>*</b>
                    </label>
                    <input name="controller"  value="{{ rule.controller }}" type="text" class="dfinput"  style="width:518px;" required/>
                    
                </li>


                <li>
                    <label>
                        行为 <b>*</b>
                    </label>
                    <input name="action" type="text" value="{{ rule.action }}" class="dfinput"  style="width:518px;" required/>
                </li>
                
                <li>
                    <label>
                        名称 <b>*</b>
                    </label>
                    <input name="title" type="text" value="{{ rule.title }}" class="dfinput"  style="width:518px;" required/>
                </li>

                <li>
                    <label>&nbsp;</label>
                    <input type="submit" class="btn" value="确　认"/>
                </li>
            </ul>
        </form>

    </div>

</div>


</div>

</body>

</html>