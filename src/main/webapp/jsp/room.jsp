<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/23
  Time: 9:43
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>后台大布局</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layuiadmin/layui/css/layui.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="${ctx}/static/plugins/layuiadmin/lib/extend/echarts.js"></script>
    <style type="text/css">
        table.dataintable {
            margin-top:15px;
            border-collapse:collapse;
            border:1px solid #aaa;
            width:100%;
        }

        table.dataintable th {
            vertical-align:baseline;
            padding:10px 10px 10px 10px;
            background-color:#3F3F3F;
            border:1px solid #3F3F3F;
            text-align:left;
            color:#fff;
        }

        table.dataintable td {
            vertical-align:text-top;
            padding:9px 9px 9px 9px;
            border:1px solid #aaa;
        }

        table.dataintable tr:nth-child(odd) {
            background-color:#F5F5F5;
        }

        table.dataintable tr:nth-child(even) {
            background-color:#fff;
        }

        table.dataintable pre {
            width:auto;
            margin:0;
            padding:0;
            border:0;
            background-color:transparent;
        }

        table.dataintable p {margin:0 0 2px 0;}

        div#maincontent table.dataintable ul, div#maincontent table.dataintable li {
            list-style-type:none;
            margin:0;
            padding:0;
        }

        table.dataintable td em
        {
            color:#0000ff;
            font-weight:normal;
        }

        table.dataintable .table_value {color:#0F93D2;}

        .no_wrap {white-space:nowrap;}
    </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <jsp:include page="/jsp/common/header.jsp"></jsp:include>
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${ctx}/jsp/student.jsp">学生</a></dd>
                        <dd class="layui-this"><a href="${ctx}/jsp/room.jsp">宿舍</a></dd>

                    </dl>
                </li>
            </ul>
        </div>
    </div>


    <div class="layui-body" style="background-color:#EEEEEE">
        <!-- 内容主体区域 -->

        <table lay-filter="test">
            <thead>
            <tr>
                <th lay-data="{field: 'room', sort: true}">宿舍</th>
                <th lay-data="{field: 'temperature'}">温度</th>
                <th lay-data="{field: 'brightness'}">亮度</th>
                <th lay-data="{field: 'humidity'}">湿度</th>
                <th lay-data="{field: 'electric'}">用电量</th>
                <th lay-data="{fixed: 'right',width: 250, align:'center', toolbar: '#barDemo'}">图表</th>
                <th lay-data="{fixed: 'right',width: 80, align:'center', toolbar: '#barDemo1'}">空调</th>
            </tr>
            </thead>
        </table>


        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="tem">温度</a>
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="hum">湿度</a>
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="light">亮度</a>
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="ele">耗电</a>
        </script>

        <script type="text/html" id="barDemo1">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="control">控制</a>
        </script>
    </div>
    <div id="Chart" style="display: none;">
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="ChartMain" style="width: 1200px; height: 400px;"></div>
    </div>

    <div class="layui-fluid" id="control" style="display: none;">

        <div class="layui-row layui-col-space5">
            <div class="layui-col-md12">
                <div class="layui-row grid-demo">
                    <div class="layui-col-md6">
                        <label class="layui-form-label">空调</label>
                    </div>
                    <div class="layui-col-md6">
                        <button id="temBtn" class="layui-btn layui-btn-normal" onclick="temBtn()">关闭</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-row layui-col-space5">
            <div class="layui-col-md12">
                <div class="layui-row grid-demo">
                    <div class="layui-col-md6">
                        <label class="layui-form-label">加湿器</label>
                    </div>
                    <div class="layui-col-md6">
                        <button id="humBtn" class="layui-btn layui-btn-normal" onclick="humBtn()">关闭</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row layui-col-space5">
            <div class="layui-col-md12">
                <div class="layui-row grid-demo">
                    <div class="layui-col-md6">
                        <label class="layui-form-label">电灯</label>
                    </div>
                    <div class="layui-col-md6">
                        <button id="lightBtn" class="layui-btn layui-btn-normal" onclick="lightBtn()">关闭</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script>
    function temBtn(){
        $.ajax({
            url:'${ctx}/room/gets',
            type:'get',
            success:function (data) {
                var i=0;
                if (data.ts=="开启") {
                    i= i+1
                }
                if (data.hs=="开启") {
                    i=i+2
                }
                if (data.ls=="开启") {
                    i=i+4
                }

                if (data.ls=="关闭"){
                    $.ajax({
                        url:'${ctx}/room/controlOn',
                        type:'post',
                        data:{
                            control:1,
                            s:i
                        },
                        success:function () {
                            $('#temBtn').html("");
                            $('#temBtn').html("开启");
                        }
                    });

                }else {
                    $.ajax({
                        url:'${ctx}/room/controlOff',
                        type:'post',
                        data:{
                            control:1,
                            s:i
                        },
                        success:function () {
                            $('#temBtn').html("");
                            $('#temBtn').html("关闭");
                        }
                    });
                }

            }
        });

    }
    function humBtn(){
        $.ajax({
            url:'${ctx}/room/gets',
            type:'get',
            success:function (data) {
                var i=0;
                if (data.ts=="开启") {
                    i=i+1
                }
                if (data.hs=="开启") {
                    i=i+2;
                }
                if (data.ls=="开启") {
                    i=i+4
                }
                if (data.ls=="关闭"){
                    $.ajax({
                        url:'${ctx}/room/controlOn',
                        type:'post',
                        data:{
                            control:2,
                            s:i
                        },
                        success:function () {
                            $('#humBtn').html("");
                            $('#humBtn').html("开启");
                        }
                    });

                }else {
                    $.ajax({
                        url:'${ctx}/room/controlOff',
                        type:'post',
                        data:{
                            control:2,
                            s:i
                        },
                        success:function () {
                            $('#humBtn').html("");
                            $('#humBtn').html("关闭");
                        }
                    });
                }

            }
        });
    }
    function lightBtn(){
        $.ajax({
            url:'${ctx}/room/gets',
            type:'get',
            success:function (data) {
                var i=0;
                if (data.ts=="开启") {
                    i=i+1
                }
                if (data.hs=="开启") {
                    i= i+2
                }
                if (data.ls=="开启") {
                    i= i+4
                }
                if (data.ls=="关闭"){
                    $.ajax({
                        url:'${ctx}/room/controlOn',
                        type:'post',
                        data:{
                            control:4,
                            s:i
                        },
                        success:function () {
                            $('#lightBtn').html("");
                            $('#lightBtn').html("开启");
                        }
                    });

                }else {
                    $.ajax({
                        url:'${ctx}/room/controlOff',
                        type:'post',
                        data:{
                            control:4,
                            s:i
                        },
                        success:function () {
                            $('#lightBtn').html("");
                            $('#lightBtn').html("关闭");
                        }
                    });
                }

            }
        });
    }
    function sss(){
        $.ajax({
            url:'${ctx}/room/gets',
            type:'get',
            success:function (data) {
                $('#temBtn').html("");
                $('#temBtn').html(data.ts);
                $('#humBtn').html("");
                $('#humBtn').html(data.hs);
                $('#lightBtn').html("");
                $('#lightBtn').html(data.ls);
            }
        });
    }
</script>

<script src="${ctx}/static/plugins/layuiadmin/layui/layui.js"></script>
<script>
    //JavaScript代码区域

    layui.use(['element', 'layer', 'table'], function(){
        var element = layui.element,
            layer = layui.layer, //弹层
            table = layui.table; //表格
        //执行一个 table 实例
        option = {
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data:[]
            },

            toolbox: {
                feature: {
                    saveAsImage: {}
                }
            },
            xAxis: {
                type: 'category',
                boundaryGap: false,
                data: []
            },
            yAxis: {
                type: 'value'
            },
            series: []
        };

        table.init('test',{
            height: 420
            ,cellMinWidth: 80 //全局定义常规单元格的最小宽度
            ,title: '宿舍'
            ,url: '${ctx}/room/roomStatue' //数据接口
            ,page: true //开启分页
            //,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
            // ,totalRow: true //开启合计行
            ,id:'roomTable'
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'tem'){
                var temChart = echarts.init(document.getElementById('ChartMain'));
                temChart.setOption(option);
                $.ajax({
                    url:'${ctx}/sensor/getTemDataWeek',
                    type:'post',
                    data:data,
                    success:function (data) {
                        temChart.setOption({        //加载数据图表
                            title : {
                                text: '一周内气温变化'
                            },
                            legend: {
                                data:['温度']
                            },
                            xAxis : {
                                type : 'category',
                                boundaryGap : false,

                                axisLabel:{
                                    interval:143
                                },
                                data : data.times
                            },
                            yAxis : {
                                type : 'value',
                                axisLabel : {
                                    formatter: '{value} °C'
                                }
                            },
                            series: [{
                                // 根据名字对应到相应的系列
                                name: '温度',
                                type:'line',
                                data: data.datum
                            }]
                        });
                        layer.open({
                            title:'温度折线图',
                            type: 1,
                            shade: false,
                            area: ['1300px', '500px'],
                            shadeClose: true, //点击遮罩关闭
                            content: $("#Chart")
                        });
                    }
                });

            }
            if(layEvent === 'control'){
                sss();
                layer.open({
                    title: '控制',
                    type: 1,
                    skin: 'layui-layer-rim', //加上边框
                    area: ['500px', '300px'], //宽高
                    content: $('#control')
                });

            }
            if(layEvent === 'hum'){
                var temChart = echarts.init(document.getElementById('ChartMain'));
                temChart.setOption(option);
                $.ajax({
                    url:'${ctx}/sensor/getHumDataWeek',
                    type:'post',
                    data:data,
                    success:function (data) {
                        temChart.setOption({        //加载数据图表
                            title : {
                                text: '一周内湿度变化'
                            },
                            legend: {
                                data:['湿度']
                            },
                            xAxis : {
                                type : 'category',
                                boundaryGap : false,

                                axisLabel:{
                                    interval:143
                                },
                                data : data.times
                            },
                            yAxis : {
                                type : 'value',
                                axisLabel : {
                                    formatter: '{value} %'
                                }
                            },
                            series: [{
                                // 根据名字对应到相应的系列
                                name: '湿度',
                                type:'line',
                                data: data.datum
                            }]
                        });
                        layer.open({
                            title:'湿度折线图',
                            type: 1,
                            shade: false,
                            area: ['1300px', '500px'],
                            shadeClose: true, //点击遮罩关闭
                            content: $("#Chart")
                        });
                    }
                });
            }
            if(layEvent === 'light'){
                var temChart = echarts.init(document.getElementById('ChartMain'));
                temChart.setOption(option);
                $.ajax({
                    url:'${ctx}/sensor/getLightDataWeek',
                    type:'post',
                    data:data,
                    success:function (data) {
                        temChart.setOption({        //加载数据图表
                            title : {
                                text: '一周内亮度变化'
                            },
                            legend: {
                                data:['亮度']
                            },
                            xAxis : {
                                type : 'category',
                                boundaryGap : false,

                                axisLabel:{
                                    interval:143
                                },
                                data : data.times
                            },
                            yAxis : {
                                type : 'value',
                                axisLabel : {
                                    formatter: '{value} nits'
                                }
                            },
                            series: [{
                                // 根据名字对应到相应的系列
                                name: '亮度',
                                type:'line',
                                data: data.datum
                            }]
                        });
                        layer.open({
                            title:'亮度折线图',
                            type: 1,
                            shade: false,
                            area: ['1300px', '500px'],
                            shadeClose: true, //点击遮罩关闭
                            content: $("#Chart")
                        });
                    }
                });
            }
            if(layEvent === 'ele'){
                layer.open({
                    type: 2,
                    title: 'layer mobile页',
                    shadeClose: true,
                    shade: 0.8,
                    area: ['380px', '50%'],
                    content: '${ctx}/room/temChart/'+room //iframe的url
                });
            }
        });
    });
</script>
</body>
</html>