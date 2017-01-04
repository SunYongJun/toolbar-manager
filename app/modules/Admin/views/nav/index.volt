<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    {{ assets.outputCss() }}
    {{ assets.outputJs() }}
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

        

        <table class="tablelist">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>名称(logo)</th>
                    <th>标题</th>
                    <th>排序</th>
                    <th>模板</th>
                    <th>样式</th>
                    <th>地区</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                {% for v in navs %}
                <tr>
                    <td>{{ v.id }}</td>
                    <td>
                        {% if v.type == 2 %}
                        <img src="{{ v.name }}" style="max-height:45px;">
                        {% else %}
                                            {{ v.name }}
                                        {% endif %}
                    </td>
                    <td>{{ v.desc }}</td>
                    <td>{{ v.ord }}</td>
                    <td>{{ tmpl[v.tmpl] }}</td>
                    <td>{{ showType[v.type] }}</td>
                    <td>{{ v.getProvinces().province }}</td>
                    <td>
                        <a href="{{url('nav/edit')}}?id={{v.id}}">修改</a>
                        |
                        <a href="{{ url('nav/del') }}?id={{ v.id }}">删除</a>
                        {% if v.tmpl != 4 %}
                                    |
                        <a href="{{ url('content/add') }}?type={{v.tmpl}}&id={{v.id}}">添加数据</a>
                        |
                        <a href="{{ url('content/index') }}?nid={{v.id}}">查看数据</a>
                    </td>
                    {% endif %}
                </tr>
                {% endfor %}
            </tbody>
        </table>

        

    <script type="text/javascript">$('.tablelist tbody tr:odd').addClass('odd');</script>

</body>

</html>