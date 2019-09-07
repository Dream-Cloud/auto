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


    <div class="layui-body" style="background-color:#EEEEEE ">
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
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="msg">推送</a>
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>

    </div>

    <div class="layui-form" lay-filter="layuiadmin-form-useradmin" id="layuiadmin-form-useradmin" style="display: none;">
        <br/>
        <br/>
        <div class="layui-form-item">
            <label class="layui-form-label">学号</label>
            <div class="layui-input-inline">
                <input type="text" name="number" lay-verify="required" placeholder="请输入学号" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-inline">
                <input type="text" name="name" lay-verify="phone" placeholder="请输入姓名" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">宿舍</label>
            <div class="layui-input-inline">
                <input type="text" name="room" lay-verify="email" placeholder="请输入宿舍" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">联系方式</label>
            <div class="layui-input-inline">
                <input type="text" name="phone" lay-verify="required" placeholder="请输入联系方式" autocomplete="off" class="layui-input" >
            </div>
        </div>
        <div class="layui-form-item" lay-filter="sex">
            <label class="layui-form-label">选择性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="0" title="男" checked>
                <input type="radio" name="sex" value="1" title="女">
            </div>
        </div>
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
            if (data.value === "0"){
                table.reload('studentTable',{
                    url:'${ctx}/student/getAll'
                });
            } else {
                table.reload('studentTable',{
                    url:'${ctx}/student/getByRoom'
                    ,where:{
                        room:data.value
                    }
                });
            }
        });
        //执行一个 table 实例
        table.render({
            elem: '#demo'
            ,height: 420
            ,url: '${ctx}/student/getAll' //数据接口
            ,title: '学生'
            ,page: true //开启分页
            ,cellMinWidth: 60 //全局定义常规单元格的最小宽度
            ,toolbar: 'default' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
            // ,totalRow: true //开启合计行
            ,id:'studentTable'
            ,cols: [[ //表头
                {type: 'checkbox', fixed: 'left'}
                ,{field: 'number', title: '学号', sort: true}
                ,{field: 'name', title: '姓名', edit: 'text'}
                ,{field: 'sex', title: '性别'}
                ,{field: 'room', title: '宿舍',  sort: true, edit: 'text'}
                ,{field: 'phone', title: '联系方式',edit: 'text'}
                ,{fixed: 'right', width: 250, align:'center', toolbar: '#barDemo'}
            ]]
        });

        //监听头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id)
                ,data = checkStatus.data; //获取选中的数据
            switch(obj.event){
                case 'add':
                    var addIndex = layer.open({
                        id:'addForm',
                        title:'添加学生',
                        type: 1,
                        shade: false,
                        btn:['提交'],
                        area: ['400px', '400px'],
                        shadeClose: true, //点击遮罩关闭
                        content: $("#layuiadmin-form-useradmin"),
                        yes: function(index, layero){
                            //按钮【按钮一】的回调
                            var sexdata = document.getElementsByName("sex");
                            var sex;
                            if(sexdata[0].checked ){
                                sex = "男";
                            }else if(sexdata[1].checked){
                                sex= "女";
                            }
                            var number = $('input[name=number]').val();
                            var name = $('input[name=name]').val();
                            var phone = $('input[name=phone]').val();
                            var room = $('input[name=room]').val();

                            if (number==""||name==""||phone==""||room=="") {
                                layer.msg('不能为空', {icon: 5});
                            }else {
                                $.ajax({
                                    url:'${ctx}/student/add',
                                    type:'post',
                                    data:{
                                        number:number,
                                        name:name ,
                                        phone:phone ,
                                        room:room,
                                        sex:sex
                                    },
                                    success:function (data) {
                                        if (data.code == 0){
                                            layer.msg('编辑成功');
                                        }else {
                                            layer.msg('编辑失败');
                                        }
                                        table.reload("studentTable");
                                    },
                                    error:function () {
                                        layer.msg("网络没响应");
                                    }
                                });
                                layer.close(addIndex);
                            }


                        }
                    });
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
                            var msg = data.msg;
                            layer.msg(msg);
                        }
                    });
                });
            } else if(layEvent === 'edit'){
                $.ajax({
                    url:'${ctx}/student/update',
                    type:'post',
                    data:data,
                    success:function (data) {
                        if (data.code == 311){
                            layer.msg('编辑成功');
                        }else {
                            layer.msg('编辑失败');
                        }

                    },
                    error:function () {
                        layer.msg("网络没响应");
                    }
                })

            }else if (layEvent === 'msg'){
                layer.prompt({title: '随便写点啥，并确认', formType: 2}, function(text, index1){
                    $.ajax({
                        url:'${ctx}/message/messageToUser',
                        type:'get',
                        data:{
                            number:data.number,
                            text:text
                        },
                        success:function (data) {
                            layer.msg(data.flag);
                            layer.close(index1);
                        },
                        error:function () {
                            layer.msg("网络没响应");
                        }
                    });


                });
            }
        });
    });
</script>
</body>
</html>