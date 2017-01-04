<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    {{ assets.outputCss() }}
    {{ assets.outputJs() }}
    <style>
    th{
        min-width: 80px;
    }
    .rules{
        float: left;
        width:148px;
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
                    <a href="{{ url('auth/groupadd') }}" class="veri">
                        <span>{{ image("images/t01.png") }}</span>
                        　添　加　
                    </a>
                </li>

                <li>
                    <a href="javascript:;" class="veri" id="delall">
                    <span>{{ image("images/t03.png") }}</span>
                    　删　除　
                    </a>
                </li>
                
            </ul>

        </div>

        <table class="tablelist">
            <thead>
                <tr>
                    <th style="width:40px;min-width:20px;">
                        <label class="uniform">
                            <input class="uniform_on" type="checkbox" id="allcheck">
                        </label>
                    </th>
                    <th style="width:47px;min-width:30px;">编号</th>
                    <th>名称</th>
                    <th>权限</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                {% for v in groups.items %}
                <tr>
                    <td>
                        <label class="uniform">
                            <input class="uniform_on ids" type="checkbox" name="ids[]" value="{{ v.id }}">
                        </label>
                    </td>
                    <td>{{ v.id }}</td>
                    <td>
                       {{ v.title }}
                    </td>

                    <td>
                    {% set num = 1 %}
                       {% for rule in v.getRules() %}
                        <div class="rules">
                            {{ num }}.{{ rule.title }}{% set num = num+1 %}
                        </div>
                            
                       {% endfor %}
                    </td>
                    <td>
                        <a href="{{url('auth/groupedit')}}?id={{v.id}}">修改</a>
                        |
                        <a href="{{ url('auth/groupdel') }}?id={{ v.id }}">删除</a>
                        
                    </td>

                </tr>
                {% endfor %}
            </tbody>
        </table>

        {% if groups.total_pages > 1 %}
            <div class="pagin">
                <div class="message">
                    共 <i class="blue">{{ groups.total_items }}</i>
                    条记录，当前显示第&nbsp; <i class="blue">{{ groups.current }}&nbsp;</i>
                    页
                </div>
                <ul class="paginList">
                    <li class="paginItem">
                        <a href="{{ param }}page={{ groups.before }}">
                            <span class="pagepre"></span>
                        </a>
                    </li>
                    {% for index in 1..groups.total_pages %}
                    <li class="paginItem">
                        <a href="{{ param }}page={{ index }}">{{ index }}</a>
                    </li>
                    {% endfor %}
                   
                    <li class="paginItem">
                        <a href="{{ param }}page={{ groups.next }}">
                            <span class="pagenxt"></span>
                        </a>
                    </li>
                </ul>
            </div>
            {% endif %}        

    <script type="text/javascript">$('.tablelist tbody tr:odd').addClass('odd');</script>
    <script>
        $(function(){
            var allcheck = document.getElementById('allcheck');
            var ids = document.getElementsByName('ids[]');

            allcheck.onclick = function(){            
                for(var i = 0 ; i < ids.length ; i++){
                    ids[i].checked = allcheck.checked;
                }
            }

            $('#delall').click(function(){
                var ruleIds = [];
                $('.ids:checked').each(function(){
                    ruleIds.push($(this).val());
                })
                $.post('{{ url("auth/groupDelAll") }}',{ids:ruleIds},function(data){
                    if(data){
                        window.location.reload();
                    }
                })
            })

        })
    </script>
</body>

</html>