<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script>
    $(function () {
        $("#usertable").jqGrid({
            url : "${path}/user/selectAll",
            datatype : "json",
            height : 190,
            colNames : [ '编号', '用户名', '昵称', '地址','头像', '性别','电话'],
            colModel : [
                {name : 'id',hidden:true,editable:false},
                {name : 'username',editable:true},
                {name : 'nickname',editable:true},
                {name : 'address',editable:true, formatter:function (value,option,rows) {
                        return rows.province+"-"+rows.city;
                    }},
                {name : 'photo',editable:true},
                {name : 'sex',editable:true,edittype:"select",editoptions:{value:"男:男;女:女"}},
                {name : 'phone',editable:true}
            ],
            rowNum : 3,
            rowList : [ 3, 5, 10],
            pager : '#userpage',
            viewrecords : true,
            autowidth: true,
            styleUI: "Bootstrap",
        })

            $("#usertable").jqGrid('navGrid', '#userpage', {
                add : false,
                edit : false,
                del : false
            });
    })






</script>




<%--初始化面板--%>
<div class="panel panel-warning">
    <%--面板头--%>
    <div class="panel panel-heading">
        <h2>用户信息</h2>
</div>

    <ul class="nav nav-tabs">
        <li class="active"><a href="#">用户信息</a></li>
        <li class="active"><a href="${path}/user/export">下载用户</a></li>
    </ul>

    <%--初始表单--%>
    <table id="usertable"/>

    <%--分页工具栏--%>
    <div id="userpage"/>
</div>

