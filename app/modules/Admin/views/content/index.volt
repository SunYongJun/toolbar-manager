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
        min-width: 60px;
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
                    <a href="{{ url('content/add') }}?nid={{ channel.id }}">
                        <span>{{ image("images/t01.png") }}</span>
                        添加
                    </a>
                </li>

                <li id="delALL">
                    <span>{{ image("images/t03.png") }}</span>
                    删除
                </li>

            </ul>

        </div>

        <table class="tablelist">
            {% if channel.tmpl == 0 %}
            <thead>
                <tr>
                    <th>
                        <input name="" type="checkbox" value=""  id="allcheck"/>
                    </th>
                    <th>编号</th>
                    <th>标题</th>
                    <th>内容</th>
                    <th>按钮</th>
                    <th>URL</th>
                    <th>地域</th>
                    <th>排序</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                {% for v in page.items %}
                
                <tr>
                    <td>
                        <input name="ids[]" class="ids"  type="checkbox" value="{{v.id}}" />
                    </td>
                    <td>{{ v.id }}</td>
                    <td>{{ v.title }}</td>
                    <td>{{ v.contents }}</td>
                    <td>{{ v.linkname }}</td>
                    <td>
                        <a href="{{ v.url }}" target="_blank">{{ v.url }}</a>
                    </td>
                    <td>{{ v.getCities().city }}</td>
                    <td>{{ v.ord }}</td>
                    <td>{{ status[v.status] }}</td>
                    <td>
                        <a href="{{url('content/edit')}}?id={{v.id}}">修改</a>
                        |
                        <a href="{{ url('content/del') }}?id={{ v.id }}&nid={{ v.nid }}">删除</a>
                    </td>
                </tr>
                {% endfor %}
            {% elseif channel.tmpl == 1 %}
                <thead>
                    <tr>
                    <th>
                        <input name="" type="checkbox" value=""  id="allcheck"/>
                    </th>
                        <th>编号</th>
                        <th>标题</th>
                        <th>内容</th>
                        <th>按钮</th>
                        <th>URL</th>
                        <th>地域</th>
                        <th>排序</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    {% for v in page.items %}
                    
                    <tr>
                        <td>
                            <input name="ids[]" class="ids"  type="checkbox" value="{{v.id}}" />
                        </td>
                        <td>{{ v.id }}</td>
                        <td>{{ v.title }}</td>
                        <td>{{ v.contents }}</td>
                        <td>{{ v.linkname }}</td>
                        <td>
                            <a href="{{ v.url }}" target="_blank">{{ v.url }}</a>
                        </td>
                        <td>{{ v.getCities().city }}</td>
                        <td>{{ v.ord }}</td>
                        <td>{{ status[v.status] }}</td>
                        <td>
                            <a href="{{url('content/edit')}}?id={{v.id}}">修改</a>
                            |
                            <a href="{{ url('content/del') }}?id={{ v.id }}&nid={{ v.nid }}">删除</a>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
                {% elseif channel.tmpl == 2 %}
                <thead>
                    <tr>
                    <th>
                        <input name="" type="checkbox" value=""  id="allcheck"/>
                    </th>
                        <th>编号</th>
                        <th>logo</th>
                        <th>名称</th>
                        <th>URL</th>
                        <th>地域</th>
                        <th>排序</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    {% for v in page.items %}
                    
                    <tr>
                        <td>
                            <input name="ids[]" class="ids"  type="checkbox" value="{{v.id}}" />
                        </td>
                        <td>{{ v.id }}</td>
                        <td>
                            <img src="{{url(v.logo)}}" style="max-height:45px;"></td>
                        <td>{{ v.title }}</td>
                        <td>
                            <a href="{{ v.url }}" target="_blank">{{ v.url }}</a>
                        </td>
                        <td>{{ v.getCities().city }}</td>
                        <td>{{ v.ord }}</td>
                        <td>{{ status[v.status] }}</td>
                        <td>
                            <a href="{{url('content/edit')}}?id={{v.id}}">修改</a>
                            |
                            <a href="{{ url('content/del') }}?id={{ v.id }}&nid={{ v.nid }}">删除</a>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
                {% elseif channel.tmpl == 3 %}
                <thead>
                    <tr>
                    <th>
                        <input name="" type="checkbox" value=""  id="allcheck"/>
                    </th>
                        <th>编号</th>
                        <th>名称</th>
                        <th>图片</th>
                        <th>URL</th>
                        <th>地域</th>
                        <th>排序</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    {% for v in page.items %}
                    
                    <tr>
                        <td>
                            <input name="ids[]" class="ids"  type="checkbox" value="{{v.id}}" />
                        </td>
                        <td>{{ v.id }}</td>
                        <td>{{ v.title }}</td>
                        <td>
                            <img src="{{url(v.logo)}}" style="max-height:45px;">
                        </td>
                        <td>
                            <a href="{{ v.url }}" target="_blank">{{ v.url }}</a>
                        </td>
                        <td>{{ v.getCities().city }}</td>
                        <td>{{ v.ord }}</td>
                        <td>{{ status[v.status] }}</td>
                        <td>
                            <a href="{{url('content/edit')}}?id={{v.id}}">修改</a>
                            |
                            <a href="{{ url('content/del') }}?id={{ v.id }}&nid={{ v.nid }}">删除</a>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
                {% elseif channel.tmpl == 5 or channel.tmpl == 6 %}
                <thead>
                    <tr>
                    <th>
                        <input name="" type="checkbox" value=""  id="allcheck"/>
                    </th>
                        <th>编号</th>
                        <th>样式</th>
                        <th>地域</th>
                        <th>排序</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    {% for v in page.items %}
                    
                    <tr>
                        <td>
                            <input name="ids[]" class="ids"  type="checkbox" value="{{v.id}}" />
                        </td>
                        <td>{{ v.id }}</td>
                        <td class="areahtml">
                            <div>{{ v.contents|escape }}</div>
                        </td>
                        <td>{{ v.getCities().city }}</td>
                        <td>{{ v.ord }}</td>
                        <td>{{ status[v.status] }}</td>
                        <td>
                            <a href="{{url('content/edit')}}?id={{v.id}}">修改</a>
                            |
                            <a href="{{ url('content/del') }}?id={{ v.id }}&nid={{ v.nid }}">删除</a>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
                {% endif %}
            </table>
            
            {% if page.total_pages > 1 %}
            <div class="pagin">
                <div class="message">
                    共 <i class="blue">{{ page.total_items }}</i>
                    条记录，当前显示第&nbsp; <i class="blue">{{ page.total_pages }}&nbsp;</i>
                    页
                </div>
                <ul class="paginList">
                    <li class="paginItem">
                        <a href="{{ param }}page={{ page.before }}">
                            <span class="pagepre"></span>
                        </a>
                    </li>
                    {% for index in 1..page.total_pages %}
                    <li class="paginItem">
                        <a href="{{ param }}page={{ index }}">{{ index }}</a>
                    </li>
                    {% endfor %}
                   
                    <li class="paginItem">
                        <a href="{{ param }}page={{ page.next }}">
                            <span class="pagenxt"></span>
                        </a>
                    </li>
                </ul>
            </div>
            {% endif %}
            

        </div>

        <script type="text/javascript">$('.tablelist tbody tr:odd').addClass('odd');</script>

</body>
<script>
        $(function(){
            var checked = true;
            $("#allcheck").bind('click',function(){
                // $(".ids").parent('span').toggleClass('checked');
                $(".ids").prop('checked',checked);
                checked = !checked;
            })

            var data = [];
            $("#delALL").bind('click',function(){
                $('.ids:checked').each(function(i,v){
                    data[i] = $(v).val();
                })
                console.log(data);
                $.post('{{ url("content/delALL") }}',{ ids : data },function(data){
                    if(data){
                        window.location.reload();
                    }
                })
            })
        })
    </script>
    </html>