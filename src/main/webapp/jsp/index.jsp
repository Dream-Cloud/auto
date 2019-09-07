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
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台大布局</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layuiadmin/layui/css/layui.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
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
                        <dd><a id="a1" href="${ctx}/jsp/student.jsp">学生</a></dd>
                        <dd><a id="a2" href="${ctx}/jsp/room.jsp">宿舍</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>



    <div class="layui-body" style="background-color:#EEEEEE">
        <!-- 内容主体区域 -->
        <BUTTON id="btn" name="btn">get</BUTTON><br>
        连接用户：<span id="s1"></span><br>
        连接宿舍：<span id="s2"></span><br>

        <table class="dataintable">
            <tr>
                <th>描述</th>
                <th>URL</th>
            </tr>
            <tr>
                <td></td>
                <td>/debug/generateWeekTem</td>
            </tr>
            <tr>
                <td></td>
                <td>/debug/generateWeekHum</td>
            </tr>
            <tr>
                <td></td>
                <td>/debug/generateWeekLight</td>
            </tr>
            <tr>
                <td>登录</td>
                <td>/student/login</td>
            </tr>
            <tr>
                <td>得到某一个宿舍的所有学生</td>
                <td>/student/getByRoom</td>
            </tr>
            <tr>
                <td>得到所有学生</td>
                <td>/student/getAll</td>
            </tr>
            <tr>
                <td>添加一个学生</td>
                <td>/student/add</td>
            </tr>
            <tr>
                <td>删除一个学生</td>
                <td>/student/delete</td>
            </tr>
            <tr>
                <td>改变某一个学生的内容</td>
                <td>/student/update</td>
            </tr>
            <tr>
                <td>查询都有那些宿舍</td>
                <td>/room/getRoomList</td>
            </tr>
            <tr>
                <td>得到某一个宿舍的各项数据</td>
                <td>/room/roomStatue</td>
            </tr>
            <tr>
                <td>添加温度数据</td>
                <td>/sensor/putTemData</td>
            </tr>
            <tr>
                <td>添加湿度数据</td>
                <td>/sensor/putHumData</td>
            </tr>
            <tr>
                <td>添加亮度数据</td>
                <td>/sensor/putLightData</td>
            </tr>
            <tr>
                <td>一周内的温度数据以显示表格</td>
                <td>/sensor/getTemDataWeek</td>
            </tr>
            <tr>
                <td>一周内的湿度数据以显示表格</td>
                <td>/sensor/getHumDataWeek</td>
            </tr>
            <tr>
                <td>一周内的亮度数据以显示表格</td>
                <td>/sensor/getLightDataWeek</td>
            </tr>
            <tr>
                <td>得到连接中的所有用户</td>
                <td>/message/getUsersList</td>
            </tr>
            <tr>
                <td>得到连接中的所有房间</td>
                <td>/message/getRoomsList</td>
            </tr>
            <tr>
                <td>发送消息给所有用户</td>
                <td>/message/messageAllUser</td>
            </tr>
            <tr>
                <td>发送消息给某一个用户</td>
                <td>/message/messageToUser</td>
            </tr>
        </table>
        其他0 增1 删2 改3 查4<br>
        学生1 宿舍2 温度3 湿度4 亮度5 登录6 通知7<br>
        成功1 失败0<br>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script src="https://raw.githubusercontent.com/sockjs/sockjs-client/master/dist/sockjs.min.js"></script>
<script>
    $(document).ready(function() {
        var ws;
        if ('WebSocket' in window) {
            ws = new WebSocket("ws://"+window.location.host+"/webSocketServer");
        } else if ('MozWebSocket' in window) {
            ws = new MozWebSocket("ws://"+window.location.host+"/webSocketServer");
        } else {
            //如果是低版本的浏览器，则用SockJS这个对象，对应了后台“sockjs/webSocketServer”这个注册器，
            //它就是用来兼容低版本浏览器的
            ws = new SockJS("http://"+window.location.host+"/sockjs/webSocketServer");
        }
        ws.onopen = function (evnt) {
        };
        //接收到消息
        ws.onmessage = function (evnt) {
            alert(evnt.data);
            $("#msg").html(evnt.data);
        };
        ws.onerror = function (evnt) {
            console.log(evnt)
        };
        ws.onclose = function (evnt) {
        }

        $("#btn1").click(function () {
            ws.close()
        });

        $("#btn").click(function () {
            $.ajax({
                url:'${ctx}/message/getUsersList',
                type:'get',
                success:function (data) {
                    $('#s1').html("");
                    var text = "";
                    for (i=0;i<data.length;i++) {
                        text += data[i]+",";
                    }
                    $('#s1').html(text);

                }
            });
            $.ajax({
                url:'${ctx}/message/getRoomsList',
                type:'get',
                success:function (data) {
                    $('#s2').html("");
                    var text = "";
                    for (i=0;i<data.length;i++) {
                        text += data[i]+",";
                    }
                    $('#s2').html(text);
                }
            });
        });


    });
</script>
<script src="${ctx}/static/plugins/layuiadmin/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
    });
</script>
</body>
</html>