<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    {{ assets.outputCss() }}
    {{ javascript_include('js/jquery-2.0.3.min.js') }}
    <style>
    .tablelist span{
        display:inline;
    }
    th{
        min-width: 50px;
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
                <a href="#">数据表</a>
            </li>
            <li>
                <a href="#">基本内容</a>
            </li>
        </ul>
    </div>

    <div class="rightinfo">

        <div class="tools">

            <ul class="toolbar">
                <li>
                    <a href="javascript:;" class="veri" value="1">
                        <span>{{ image("images/t01.png") }}</span>
                        　通　过　
                    </a>
                </li>

                <li>
                    <a href="javascript:;" class="veri" value="4">
                    <span>{{ image("images/t03.png") }}</span>
                    　否　决　
                    </a>
                </li>
                
            </ul>

        </div>
        {{ form('verify/exec','id':'vrf') }}
        <table class="tablelist">
            <thead>
                <tr>
                    <th>
                        <label class="uniform">
                            <input class="uniform_on" type="checkbox" id="allcheck"></label>
                    </th>
                    <th style="min-width:60px;">频道</th>
                    <th>标题</th>
                    <th>logo</th>
                    <th>内容</th>
                    <th>url</th>
                    <th style="min-width:70px;">操作</th>
                </tr>
            </thead>
            <tbody>
                {% for v in result %}
                <tr>
                    <td>
                        <label class="uniform">
                            <input class="uniform_on ids" type="checkbox" name="ids[]" value="{{ v.id }}"></label>
                    </td>
                    <td>{{ v.getNav().name }}</td>
                    <td>{{ v.title }}</td>
                    <td>
                        <img src="{{ url(v.logo) }}" style="max-height:50px;" alt="logo"></td>
                    <td>{{ v.contents }}</td>
                    <td>
                        <a href="{{ v.url }}" target="_blank">{{ v.url }}</a>
                    </td>

                    <td>
                        <a href="{{url('verify/exec')}}?id={{v.id}}&status=1">通过</a>
                        |
                        <a href="{{ url('verify/exec') }}?id={{ v.id }}&status=4">否决 </a>
                    </td>
                </tr>
                {% endfor %}
            </tbody>
        </table>
    </form>
    <script type="text/javascript">$('.tablelist tbody tr:odd').addClass('odd');</script>
    <script>
        $(function(){
            var checked = true;
            $("#allcheck").bind('click',function(){
                $(".ids").prop('checked',checked);
                checked = !checked;
            })

            $(".veri").bind('click',function(){
                $("#vrf").attr('action',$("#vrf").attr('action')+'?status='+$(this).attr('value'));
                if($('.ids:checked').length){
                    $("#vrf").submit();
                }
                
            })
        })
    </script>
</body>

</html>