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

        <div class="tools">

            <ul class="toolbar">
                <li>
                    <a href="{{ url('user/add') }}">
                        <span>{{ image("images/t01.png") }}</span>
                        添加
                    </a>
                </li>

                <li>
                    <span>{{ image("images/t03.png") }}</span>
                    删除
                </li>

            </ul>

        </div>

        <table class="tablelist">
            <thead>
                <tr>
                    <th>编号</th>
                    <th>邮箱</th>
                    <th>昵称</th>
                    <th>地域</th>
                    <th>手机</th>
                    <th>公司</th>
                    <th>地址</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                {% for v in users %}
                <tr>
                    <td>{{ v.id }}</td>
                    <td>{{ v.email }}</td>
                    <td>{{ v.name }}</td>
                    <td>{{ v.getProvinces().province }}</td>
                    <td>{{ v.phone }}</td>
                    <td>{{ v.company }}</td>
                    <td>{{ v.addr }}</td>
                    <td>{{ status[v.status] }}</td>
                    <td>
                        <a href="{{url('user/edit')}}?id={{v.id}}">修改</a>
                        |
                        <a href="{{ url('user/del') }}?id={{ v.id }}">删除</a>
                    </td>
                </tr>
                {% endfor %}
            </tbody>
        </table>

        <script type="text/javascript">$('.tablelist tbody tr:odd').addClass('odd');</script>

</body>

    </html>