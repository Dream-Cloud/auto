<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/6
  Time: 9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>websocket</title>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://raw.githubusercontent.com/sockjs/sockjs-client/master/dist/sockjs.min.js"></script>
</head>
<body>
当前登录用户：${pageContext.session.getAttribute("username")}<br>
<input type="text" id="text">
<button id="btn1" value="发送给后台">发送给后台</button>
<button id="btn2" value="发送给其他用户">发送给其他用户</button>
<div id="msg"></div>

</body>
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

            ws.send($("#text").val());
        });
        $("#btn2").bind("click",function () {
            var url = "${pageContext.request.contextPath}/webSocket/message";
            var content =  $("#text").val();
            var toUserName = "admin"
            $.ajax({
                data: "content=" + content + "&toUserName=" + toUserName,
                type: "get",
                dataType: 'text',
                async: false,
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                encoding: "UTF-8",
                url: url,
                success: function (data) {
                    alert(data.toString());
                },
                error: function (msg) {
                    alert(msg);
                },

            });

        })
    });

</script>
</html>

