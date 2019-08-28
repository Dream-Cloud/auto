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

    <!--<meta charset="utf-8">-->
    <!--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">-->
    <title>后台大布局</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layuiadmin/layui/css/layui.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="${ctx}/static/plugins/layuiadmin/lib/extend/echarts.js"></script>
    <!--<style>-->

    <!--body{margin: 10px;}-->
    <!--.demo-carousel{height: 200px; line-height: 200px; text-align: center;}-->
    <!--</style>-->
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


    <div class="layui-body">
        <!-- 内容主体区域 -->

        <table lay-filter="test">
            <thead>
            <tr>
                <th lay-data="{type: 'checkbox', fixed: 'left'}"></th>
                <th lay-data="{field: 'room', sort: true}">宿舍</th>
                <th lay-data="{field: 'temperature'}">温度</th>
                <th lay-data="{field: 'brightness'}">亮度</th>
                <th lay-data="{field: 'humidity'}">湿度</th>
                <th lay-data="{field: 'electric'}">用电量</th>
                <th lay-data="{fixed: 'right',width: 250, align:'center', toolbar: '#barDemo'}">图表</th>
                <th lay-data="{fixed: 'right',width: 80, align:'center', toolbar: '#barDemo1'}">空调</th>
                <th lay-data="{fixed: 'right',width: 80, align:'center', toolbar: '#barDemo2'}">加湿器</th>
                <th lay-data="{fixed: 'right',width: 80, align:'center', toolbar: '#barDemo3'}">灯</th>
                <th lay-data="{fixed: 'right',width: 80, align:'center', toolbar: '#barDemo4'}">电源</th>
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
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="ctem"><span id="temc">关闭</span></a>
            </script>
        <script type="text/html" id="barDemo2">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="chum"><span id="humc">关闭</span></a>
            </script>
        <script type="text/html" id="barDemo3">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="clight"><span id="lightc">关闭</span></a>
        </script>
        <script type="text/html" id="barDemo4">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="cele"><span id="elec">关闭</span></a>
        </script>
    </div>
    <div id="temChart" style="display: none;">
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="temChartMain" style="width: 1200px; height: 400px;"></div>
    </div>
    <div id="humChart" style="display: none;">
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="humChartMain" style="width: 1200px; height: 400px;"></div>
    </div>
    <div id="lightChart" style="display: none;">
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="lightChartMain" style="width: 1200px; height: 400px;"></div>
    </div>
    <div id="elecChart" style="display: none;">
        <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
        <div id="elecChartMain" style="width: 600px; height: 400px;"></div>
    </div>
    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>


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
                var temChart = echarts.init(document.getElementById('temChartMain'));
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
                                data: data.datas
                            }]
                        });
                        layer.open({
                            title:'温度折线图',
                            type: 1,
                            shade: false,
                            area: ['1300px', '500px'],
                            shadeClose: true, //点击遮罩关闭
                            content: $("#temChart")
                        });
                    }
                });

            }
            if(layEvent === 'ctem'){
                $('#temc').html("");
                $('#temc').html("开启");

            }

            if(layEvent === 'hum'){
                var temChart = echarts.init(document.getElementById('humChartMain'));
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
                                data: data.datas
                            }]
                        });
                        layer.open({
                            title:'湿度折线图',
                            type: 1,
                            shade: false,
                            area: ['1300px', '500px'],
                            shadeClose: true, //点击遮罩关闭
                            content: $("#humChart")
                        });
                    }
                });
            }
            if(layEvent === 'light'){
                var temChart = echarts.init(document.getElementById('lightChartMain'));
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
                                data: data.datas
                            }]
                        });
                        layer.open({
                            title:'亮度折线图',
                            type: 1,
                            shade: false,
                            area: ['1300px', '500px'],
                            shadeClose: true, //点击遮罩关闭
                            content: $("#lightChart")
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