<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<script>

    //初始化表单
    $(function(){
        pageInit();
    });
    function pageInit(){
        $("#bntable").jqGrid(
            {
                url : '${path}/banner/selectAll',
                datatype : "json",
                rowNum : 3,     //每页显示条数
                rowList : [ 3, 5, 10 ],   //可选展示条数
                pager : '#bnpage',     //分页工具栏
                viewrecords : true,    //是否显示总条数
                styleUI : "Bootstrap",  //表格使用bootstrap样式
                height : 250,
                autowidth: true,
                editurl : "${path}/banner/edit",
                colNames : [ '编号', '名称', '封面', '描述', '状态','上传日期'],
                colModel : [
                    {name : 'id', hidden:true,editable:false},
                    {name : 'name',editable:true },
                    {name : 'cover',editable:true,edittype:"file",formatter:function (value,option,rows) {
                            return "<img style='width:100px; height:70px' src='${path}/banner/img/"+rows.cover+"'>";
                        }},
                    {name : 'description',editable:true},
                    {name : 'status',editable:true,edittype:"select",editoptions:{value:"正常:正常;冻结:冻结"}},
                    {name : 'createDate'}
                ],

            });

        //处理表单中增删改操作
        $("#bntable").jqGrid('navGrid', '#bnpage',
            {
            edit : true,
            edittext : "修改",
            add : true,
            addtext : "添加",
            del : true,
            deltext : "删除",
            search:false
            },
            {
                closeAfterEdit:true,
                beforeShowForm:function (fmt) {
                    fmt.find("#cover").attr("disabled",true);
                }
            },   //执行修改操作的额外配置
            {
                closeAfterAdd: true,    //提交之后关闭对话框
                afterSubmit:function (data) {
                    var status =data.responseJSON.status;
                    var id = data.responseJSON.message;
                    if(status){
                        $.ajaxFileUpload({
                            url:"${path}/banner/upload",
                            type:"post",
                            fileElementId:"cover",
                            data:{id:id},
                            success:function (response) {
                                //自动刷新jqgrid表格
                                $("#bntable").trigger("reloadGrid");
                            }
                        })
                    }
                    return "123";
                }
            },   //执行添加操作的额外配置
            {}    //执行删除操作的额外配置
        );
    }
</script>

<%--初始化面板--%>
<div class="panel panel-info">
    <%--面板头--%>
    <div class="panel panel-heading">
        <h2>轮播图信息</h2>
    </div>

    <ul class="nav nav-tabs">
        <li class="active"><a href="#">轮播图信息</a></li>
    </ul>

    <%--初始表单--%>
    <table id="bntable"/>

    <%--分页工具栏--%>
    <div id="bnpage"/>
</div>