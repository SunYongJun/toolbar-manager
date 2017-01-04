<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    {{ stylesheet_link('css/jquery-ui-1.9.2.custom.css') }}
    {{ assets.outputCss() }}
    {{ stylesheet_link('css/select.css') }}
    {{ javascript_include('js/jquery-2.0.3.min.js') }}
    {{ javascript_include('fusioncharts/js/fusioncharts.js') }}
    {{ javascript_include('fusioncharts/js/themes/fusioncharts.theme.fint.js') }}
    {{ javascript_include('js/select-ui.min.js') }}
    {{ javascript_include('js/jquery-ui-1.9.2.custom.js') }}
    {{ javascript_include('js/share.js') }}
    <script type="text/javascript">
        $(document).ready(function(e) {

            $(".select3").uedSelect({
                width : 152
            });
        });

        var contents = [],tags = [], btns = [],btnc = [] , date = [];
        {% for v in result %}
            {% if v.stat.type == 1 %}btnc{% elseif v.stat.type == 2 %}tags{% elseif v.stat.type == 3 %}contents{% elseif v.stat.type == 4 %}date.push({"label":"{{ "%d"|format(v.stat.time / 100) }}"});btns{% endif %}.push({"value":"{{ v.sclick }}"});
        {% endfor %}


function reRender(){
    FusionCharts.ready(function(){
            var content = new FusionCharts({
                "type": "scrollline2d",
                // "type": "column3d",
                // "type":"angulargauge",
                // "type":"pie3d",
                "renderAt": "chartContent",
                "width": "1000",
                "height": "400",
                "dataFormat": "json",
                "dataSource":  
                {
    "chart": {
        "caption": "总览图",
        "subCaption": "",
        "xAxisName": "日期",
        "yAxisName": "次数",
        "paletteColors": "#00ff00,#00ffff,#ff00ff,#ffff00",
        "bgAlpha": "0",
        "borderAlpha": "20",
        "canvasBorderAlpha": "0",
        "LegendShadow": "0",
        "legendBorderAlpha": "0",
        "showXAxisLine": "1",
        "showValues": "0",
        "showBorder": "0",
        "showAlternateHgridColor": "0",
        "base": "10",
        "numberprefix": "",
        "axisLineAlpha": "10",
        "divLineAlpha": "10",
        "toolTipColor": "#ffffff",
        "toolTipBorderThickness": "0",
        "toolTipBgColor": "#000000",
        "toolTipBgAlpha": "80",
        "toolTipBorderRadius": "2",
        "toolTipPadding": "5"
    },
    "categories": [
        {
            "category": date
        }
    ],
    "dataset": [
        {
            "seriesname": "内容",
            "data": contents
        },
        {
            "seriesname": "频道",
            "data": tags
        },
        {
            "seriesname": "logo展示",
            "data": btns
        },
        {
            "seriesname": "logo点击",
            "data": btnc
        }
    ]
}

            });
            content.render();
            })
}
        reRender();

        
    </script>
</head>

<body class="sarchbody">

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
        <form action="?" method="post">
            <div id="usual1" class="usual">

                <ul class="seachform1">

                    <li>
                        <label>日期</label>
                        <input name="startDate" type="text" class="scinput1 startDate" value="2014/12/20" id="startDate"/>
                        -
                        <input name="endDate" id="endDate" class="endDate scinput1" readonly  value="2014/12/20" type="text" disabled onChange="datePickers()"></li>

                    <li>
                        <label></label>
                        <input name="" type="submit" class="scbtn" value="查询"/>
                    </li>

                </ul>
            </div>
        </form>
        <script language="javascript">
                $(document).ready(function(){ 


                    $('.typeCh').change(function(){
                        reRender(tag);
                    })



                    $(".scbtn1").click(function() 
                    {      
                        if( $(".seachform2").hasClass("hideclass") ) 
                        { 
                            $(".seachform2").removeClass("hideClass"); 
                        } 
                        else 
                        { 
                            $(".seachform2").addClass("hideClass"); 
                        }    
                    }); 
                }); 

                $(document).ready(function(){
                    $(".scbtn1").click(function(){
                        $(".seachform2").fadeIn(200);
                    }); 
                });
            </script>

        <div id="chartContent">正在加载...</div>

        <div class="formtitle">
            <span>列表</span>
        </div>

        <table class="tablelist">
            <thead>
                <tr>

                    <th>日期</th>
                    <th>Logo展示</th>
                    <th>Logo点击</th>
                    <th>频道点击</th>
                    <th>内容点击</th>
                    <th>Logo点记率</th>
                </tr>
            </thead>
            <tbody>
                {% for k,v  in byDate %}
                <tr>
                    <td>{{ k }}</td>
                    <td>{{ v[4] }}</td>
                    <td>{{ v[1] }}</td>
                    <td>{{ v[2] }}</td>
                    <td>{{ v[3] }}</td>
                    <td>{{ "%.2f"|format(v[1] * 100 / v[4]) }}%</td>
                </tr>
                {% endfor %}
            </tbody>
        </table>

    </div>

</div>

</body>

</html>