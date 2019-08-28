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
                        <dd class="layui-this"><a href="${ctx}/jsp/student.jsp">学生</a></dd>
                        <dd><a href="${ctx}/jsp/room.jsp">宿舍</a></dd>

                    </dl>
                </li>
            </ul>
        </div>
    </div>


    <div class="layui-body">
        <!-- 内容主体区域 -->
        <form class="layui-form" action="">
            <br>
            <div class="layui-form-item">
                <label class="layui-form-label">搜索</label>
                <div class="layui-input-inline">
                    <select lay-verify="required" lay-filter="search" name="search" id="search" lay-search></select>
                </div>
            </div>
        </form>
        <table class="layui-hide" id="demo" lay-filter="test"></table>

        <script type="text/html" id="barDemo">
            <!--<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>-->
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>

    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>


<script src="${ctx}/static/plugins/layuiadmin/layui/layui.js"></script>
<script>
    //JavaScript代码区域

    layui.use(['element','layer', 'table','form'], function(){
        var element = layui.element,
            layer = layui.layer, //弹层
            table = layui.table, //表格
            form = layui.form;


            var htmls = '<option value="0">请选择</option>'; //全局变量
            $.ajax({
                url:'${ctx}/room/getRoomList',
                type:'post',
                dataType:'json',
                contentType : "application/json",
                async:false,
                success:function(result){
                    for(var x in result){
                        htmls += '<option value = "' + result[x] + '">' + result[x] + '</option>'
                    }
                    $("#search").html(htmls);
                    form.render('select');
                }
            });
        form.on('select(search)', function(data){
            table.reload('studentTable',{
                url:'${ctx}/student/getByRoom'
                ,where:{
                    room:data.value
                }
            });
        });
        //执行一个 table 实例
        table.render({
            elem: '#demo'
            ,height: 420
            ,url: '${ctx}/student/getAll' //数据接口
            ,title: '学生'
            ,page: true //开启分页
            ,cellMinWidth: 80 //全局定义常规单元格的最小宽度
            ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
            // ,totalRow: true //开启合计行
            ,id:'studentTable'
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{field: 'number', title: '学号', sort: true}
                ,{field: 'name', title: '名字', edit: 'text'}
                ,{field: 'room', title: '宿舍',  sort: true}
                ,{field: 'phone', title: '联系方式',edit: 'text'}
                ,{fixed: 'right', width: 165, align:'center', toolbar: '#barDemo'}
            ]]
        });

        //监听头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id)
                ,data = checkStatus.data; //获取选中的数据
            switch(obj.event){
                case 'add':
                    break;
                case 'update':
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else if(data.length > 1){
                        layer.msg('只能同时编辑一个');
                    } else {
                        layer.alert('编辑 [id]：'+ checkStatus.data[0].id);
                    }
                    break;
                case 'delete':
                    if(data.length === 0){
                        layer.msg('请选择一行');
                    } else {
                        layer.msg('删除');
                    }
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令

                    $.ajax({
                        url:'${ctx}/student/delete/',
                        type:'post',
                        data:data,
                        success:function (data) {
                            var msg = data.msg
                            layer.msg(msg);
                        }
                    });
                });
            } else if(layEvent === 'edit'){

                console.log(data.toString())
                $.ajax({
                    url:'${ctx}/student/update',
                    type:'post',
                    data:data,
                    success:function (data1) {
                        if (data1 == '1'){
                            layer.msg('编辑成功');
                        }else {
                            layer.msg('编辑失败');
                        }

                    }
                })

            }
        });
    });
</script>
</body>
</html>