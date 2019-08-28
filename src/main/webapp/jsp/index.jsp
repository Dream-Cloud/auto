<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/22
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台大布局</title>
    <link rel="stylesheet" href="${ctx}/static/plugins/layuiadmin/layui/css/layui.css">
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://raw.githubusercontent.com/sockjs/sockjs-client/master/dist/sockjs.min.js"></script>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/jsp/common/header.jsp"/>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href="javascript:;">管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="${ctx}/jsp/student.jsp">学生</a></dd>
                        <dd><a href="${ctx}/jsp/room.jsp">宿舍</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>


    <div class="layui-body">
        <!-- 内容主体区域 -->
        连接用户：${pageContext.session.getAttribute("usersList")}<br>
        连接宿舍：${pageContext.session.getAttribute("roomsList")}<br>
    </div>

    <jsp:include page="/jsp/common/bottom.jsp"/>
</div>
<script src="${ctx}/static/plugins/layuiadmin/layui/layui.js"></script>
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
    });
</script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
    });
</script>
</body>
</html>