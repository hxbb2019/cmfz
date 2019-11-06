<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<script>
    $(function () {
        $("#startable").jqGrid(
            {
                url : "${path}/star/selectAll",
                editurl: "${path}/star/edit",
                datatype : "json",
                height : 190,
                colNames : [ '编号', '艺名', '真名', '头像','性别', '生日'],
                colModel : [
                    {name : 'id',hidden:true,editable:false},
                    {name : 'nickname',editable:true},
                    {name : 'realname',editable:true},
                    {name : 'photo',editable:true,edittype:"file", formatter:function (value,option,rows) {
                            return "<img style='width:100px; height:70px' src='${path}/star/img/"+rows.photo+"'>";
                        }},
                    {name : 'sex',editable:true,edittype:"select",editoptions:{value:"男:男;女:女"}},
                    {name : 'bir',editable:true,edittype:"date"}
                ],
                rowNum : 3,
                rowList : [ 3, 5, 10],
                pager : '#starpage',
                viewrecords : true,
                autowidth: true,
                styleUI: "Bootstrap",
                subGrid : true,
                subGridRowExpanded : function(subgrid_id, id) {
                    // we pass two parameters
                    // subgrid_id is a id of the div tag created whitin a table data
                    // the id of this elemenet is a combination of the "sg_" + id of the row
                    // the row_id is the id of the row
                    // If we wan to pass additinal parameters to the url we can use
                    // a method getRowData(row_id) - which returns associative array in type name-value
                    // here we can easy construct the flowing
                    var subgrid_table_id, pager_id;
                    subgrid_table_id = subgrid_id + "_t";
                    pager_id = "p_" + subgrid_table_id;
                    $("#" + subgrid_id).html(
                        "<table id='" + subgrid_table_id
                        + "' class='scroll'></table><div id='"
                        + pager_id + "' class='scroll'></div>");
                    $("#" + subgrid_table_id).jqGrid(
                        {
                            url : "${path}/user/selectUserByStarId?starId=" + id,
                            datatype : "json",
                            colNames : [ '编号', '用户名','昵称', '头像', '电话','性别','地址','签名' ],
                            colModel : [
                                {name : "id"},
                                {name : "username"},
                                {name : "nickname"},
                                {name : "photo"},
                                {name : "phone"},
                                {name : "sex"},
                                {name : "address"},
                                {name : "sign"}

                            ],
                            rowNum : 2,
                            pager : pager_id,
                            styleUI : 'Bootstrap',
                            autowidth : true,
                            height : '100%'
                        });
                    $("#" + subgrid_table_id).jqGrid('navGrid',
                        "#" + pager_id, {
                            edit : false,
                            add : false,
                            del : false,
                            search : false
                        });
                },
                subGridRowColapsed : function(subgrid_id, row_id) {
                    // this function is called before removing the data
                    //var subgrid_table_id;
                    //subgrid_table_id = subgrid_id+"_t";
                    //jQuery("#"+subgrid_table_id).remove();
                }
            });
        $("#startable").jqGrid('navGrid', '#starpage', {
                add : true,
                edit : false,
                del : false
            },
            {},
            {
                closeAfterAdd: true,    //提交之后关闭对话框
                afterSubmit:function (data) {
                    var status = data.responseJSON.status;
                    var id = data.responseJSON.message;
                    if (status){
                        $.ajaxFileUpload({
                            url:"${path}/star/upload",
                            type:"post",
                            fileElementId:"photo",
                            data:{id:id},
                            success:function (response) {
                                $("#startable").trigger("reloadGrid");
                            }


                        })
                    }
                    return "123";
                }

            },
            {});
    })

</script>

<%--初始化面板--%>
<div class="panel panel-danger">
    <%--面板头--%>
    <div class="panel panel-heading">
        <h2>明星信息</h2>
    </div>

    <ul class="nav nav-tabs">
        <li class="active"><a href="#">明星信息</a></li>
    </ul>

    <%--初始表单--%>
    <table id="startable"/>

    <%--分页工具栏--%>
    <div id="starpage"/>
</div>