<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    {{ assets.outputCss() }}
    {{ assets.outputJs() }}
    {{ javascript_include('fusioncharts/js/fusioncharts.js') }}
    {{ javascript_include('fusioncharts/js/themes/fusioncharts.theme.fint.js') }}
    <style>
    #mobileTB{
        margin: 10px 0 0 30px;
        width:320px;
        height:480px;
        border-top: 85px  double #fff;
        border-bottom: 86px  double #fff;
        border-left: 20px  double #fff;
        border-right: 20px  double #fff;
        border-image: url('{{ url("images/iphone6.png") }}') 106 26  stretch   stretch;
    }
    .detail{
        float: left;
        margin: 20px 50px;
    }
    .tb-btn{
        width: 50px;
        border-radius:50% 50%;
    }
    .cl{
        clear:both;
    }
    .line{
        display: inline;
    }
    .fl{
        float: left;
    }
    .mah{
        margin-left: 20px;
        margin-right: 20px;
    }
    th{
        min-width: 50px;
    }
    </style>
    <script type="text/javascript">
  FusionCharts.ready(function(){
    var revenueChart = new FusionCharts({
        //"type": "column2d",
        // "type": "column3d",
        // "type":"angulargauge",
        "type":"pie3d",
        "renderAt": "chartContainer",
        "width": "500",
        "height": "300",
        "dataFormat": "json",
        "dataSource":  
        {
            "chart": {
                "caption": "频道点击数据",
                "subcaption": "",
                "startingangle": "120",
                "showlabels": "0",
                "showlegend": "1",
                "enablemultislicing": "0",
                "slicingdistance": "15",
                "showpercentvalues": "1",
                "showpercentintooltip": "0",
                "plottooltext": "$label 点击数:$datavalue",
                "theme": "fint"
            },
            "data": [

                {% for v in tag %}
                    {
                        "label" : "{{ v.nav.name }}",
                        "value" : "{{ v.click }}"
                    },
                {% endfor %}

                /*{
                    "label": "流量",
                    "value": "1250400"
                },
                {
                    "label": "生活",
                    "value": "125400"
                },
                {
                    "label": "应用",
                    "value": "1250400"
                },
                {
                    "label": "活动",
                    "value": "1463300"
                },
                {
                    "label": "测试",
                    "value": "1050700"
                },
                {
                    "label": "导航",
                    "value": "491000"
                }*/
            ]
        }

    });
    revenueChart.render();


    var content = new FusionCharts({
        "type": "column3d",
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
                "caption": "内容点击数据",
                "subcaption": "",
                // "startingangle": "10",
                "xAxisName": "名称",
                "yAxisName": "点击",
                "numberPrefix": "",
                "numberSuffix": "",
                "paletteColors": "#000",
                // "paletteColors": "#0075c2",
                // "canvasBorderAlpha": "0",

                // "usePlotGradientColor": "0",
                // "plotBorderAlpha": "10",
                "placevaluesInside": "1",
                "rotatevalues": "1",
                "valueFontColor": "#ffffff",
                "showXAxisLine": "1",
                "xAxisLineColor": "#999999",
                "divlineColor": "#999999",
                "divLineDashed": "1",
                "showAlternateHGridColor": "0",
                "subcaptionFontBold": "0",
                // "subcaptionFontSize": "14"

                "bgColor": "#ffffff",
                // "borderAlpha": "20",
                // "showlabels": "1",
                // "showlegend": "0",
                // "enablemultislicing": "0",
                // "slicingdistance": "5",
                // "showpercentvalues": "1",
                // "showpercentintooltip": "0",
                // "plottooltext": "Content : $label Click : $datavalue",
                "theme": "fint"
            },
            "data": [
                {% for v in contents %}
                    {
                        "label" : "{{ v.content.title|striptags }}",
                        "value" : "{{ v.click }}"
                    },
                {% endfor %}

                /*{
                    "label": "100M国内流量包",
                    "value": "1250"
                },
                {
                    "label": "300M国内流量包",
                    "value": "120"
                },
                {
                    "label": "500M国内流量包",
                    "value": "1250"
                },
                {
                    "label": "1G国内流量包",
                    "value": "1460"
                },
                {
                    "label": "测试",
                    "value": "1050"
                },
                {
                    "label": "导航",
                    "value": "490"
                }*/
            ],
            "trendlines": [
                {
                    "line": [
                        {
                            "startvalue": "700000",
                            "color": "#1aaf5d",
                            "valueOnRight": "1",
                            "displayvalue": "Monthly Target"
                        }
                    ]
                }
            ]
        }

    });
    content.render();


    var uskadbtn = new FusionCharts({
        "type": "line",
        // "type": "column3d",
        // "type":"angulargauge",
        // "type":"pie3d",
        "renderAt": "uskadbtn",
        "width": "500",
        "height": "300",
        "dataFormat": "json",
        "dataSource":  
        
        {
            "chart": {
                "caption": "图标点击次数统计",
                "subCaption": "最近5次",
                "showBorder": "0",
                "xAxisName": "时",
                "yAxisName": "点击数",
                "numberSuffix": "",
                "lineThickness": "2",
                "paletteColors": "#008ee4,#6baa01",
                "baseFontColor": "#333333",
                "baseFont": "Helvetica Neue,Arial",
                "captionFontSize": "14",
                "subcaptionFontSize": "14",
                "subcaptionFontBold": "0",
                "bgColor": "#ffffff",
                "showShadow": "0",
                "showLegend": "0",
                "canvasBgColor": "#ffffff",
                "canvasBorderAlpha": "0",
                "divlineAlpha": "100",
                "divlineColor": "#999999",
                "divlineThickness": "1",
                "divLineDashed": "1",
                "divLineDashLen": "1",
                "divLineGapLen": "1",
                "showXAxisLine": "1",
                "xAxisLineThickness": "1",
                "xAxisLineColor": "#999999",
                "showAlternateHGridColor": "0",
                "toolTipColor": "#ffffff",
                "toolTipBorderThickness": "0",
                "toolTipBgColor": "#000000",
                "toolTipBgAlpha": "80",
                "toolTipBorderRadius": "2",
                // "toolTipPadding": "5"
            },
            "data": [

                {% for v in btn %}
                    {
                        "label" : "{{ v.time[6] }}{{ v.time[7] }}日{{ v.time[8] }}{{v.time[9]}}时",
                        "value" : "{{ v.click }}"
                    },
                {% endfor %}
                /*{
                    "label": "Mon",
                    "value": "123"
                },
                {
                    "label": "Tue",
                    "value": "133"
                },
                {
                    "label": "Wed",
                    "value": "237"
                },
                {
                    "label": "Thu",
                    "value": "90"
                },
                {
                    "label": "Fri",
                    "value": "129"
                },
                {
                    "label": "Sat",
                    "value": "203"
                },
                {
                    "label": "Sun",
                    "value": "102"
                }*/
            ],
            
        }
        

    });
    uskadbtn.render();

})
</script>
</head>

<body>

    <div class="place">
        <span>位置：</span>
        <ul class="placeul">
            <li>
                <a href="#">首页</a>
            </li>
        </ul>
    </div>

    <div class="mainindex">

        <div class="welinfo">
            <span></span> <b>您好 {{ session.get('user')['email'] }} ，欢迎使用ToolBar管理系统！</b>

        </div>

        <div class="welinfo">
            <span>{{ image('images/time.png') }}</span> <i>您上次登录的时间：{{ date('Y-m-d H:i:s',session.get('user')['mtime']) }}</i> 

        </div>

        <div class="xline"></div>

    </div>

    <div class="mainbox">

        <div class="mainleft">

            <div class="leftinfo">
                <div class="listtitle">效果展示</div>

                <div class="maintj">
                    <iframe src="{{ url('main/mobileTB') }}" id="mobileTB" scrolling="no"></iframe>
                </div>

                <div class="detail">
                    <div class="">

                        
                    </div>

                </div>
            </div>
            <div class="mainright">

                <div class="dflist">
                    <div class="listtitle">
                        <a href="#" class="more1"></a>
                        频道
                        <div id="chartContainer">FusionCharts XT will load here!</div>
                    </div>
                </div>

                <div class="dflist1">
                    <div class="listtitle">
                        <a href="#" class="more1"></a>
                        图标
                        <div id="uskadbtn"></div>
                    </div>
                </div>

            </div>
        </div>

        <div class="rightinfo">

            <div class="welinfo" style="height:680px">

                <div class="detail">
                    <div class="">
                        

                    </div>
                    <div class="cl"></div>
                </div>
                <div class="detail">

                    <div class="xline"></div>

                    <div class="fl">

                        <div id="chartContent">FusionCharts XT will load here!</div>

                    </div>
                    <div class="cl"></div>
                </div>
                <div class="detail">

                    <div class="xline"></div>
                </div>

            </div>
        </div>
    </div>

</body>

</html>