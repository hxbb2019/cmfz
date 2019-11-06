<%@page contentType="text/html; UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<script>
    $(function () {
        $("#albumtable").jqGrid(
            {
                url : '${path}/album/selectAll',
                datatype : "json",
                height : 190,
                colNames : [ '编号', '专辑名称', '专辑作者', '专辑封面', '音乐数量','专辑简介', '创建时间' ],
                colModel : [
                    {name : 'id' ,hidden:true},
                    {name : 'name',editable:true},
                    {name : 'starId',editable:true,edittype:"select",editoptions:{dataUrl:"${path}/star/getAllStarForSelect"},formatter:function (value,option,rows) {
                            return rows.star.nickname;}},
                    {name : 'cover',editable:true,edittype:"file" ,formatter:function (value,option,rows) {
                            return "<img style='width:100px; height:70px' src='${path}/album/img/"+rows.cover+"'>";}},
                    {name : 'count'},
                    {name : 'brief',editable:true},
                    {name : 'createDate',editable:true,edittype:"date"}
                ],
                editurl : "${path}/album/edit",
                rowNum : 3,
                rowList : [ 3, 5, 10],
                pager : '#albumpage',
                viewrecords : true,
                styleUI : "Bootstrap",
                autowidth : true,
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
                            url : "${path}/chapter/selectAll?albumId=" + id,
                            datatype : "json",
                            colNames : [ '编号', '名字', '歌手', '大小','时长','创建时间','在线播放' ],
                            colModel : [
                                {name : "id",hidden:true},
                                {name : "name",editable:true,edittype:"file"},
                                {name : "singer",editable:true},
                                {name : "size"},
                                {name : "duration"},
                                {name : "createDate"},
                                {name : "operation",width:300,formatter:function (value,option,rows) {
                                        return "<audio controls>\n" +
                                            "  <source src='${path}/album/music/"+rows.name+"' >\n" +
                                            "</audio>"
                                    }}
                            ],
                            rowNum : 20,
                            pager : pager_id,
                            styleUI : "Bootstrap",
                            autowidth : true,
                            height : '100%',
                            editurl:"${path}/chapter/edit?albumId="+id
                        });
                    jQuery("#" + subgrid_table_id).jqGrid('navGrid',
                        "#" + pager_id, {
                            edit : false,
                            add : true,
                            del : false,
                            search : false
                        },
                        {},
                        {
                            closeAfterAdd : true,
                            afterSubmit : function (data) {
                                var status = data.responseJSON.status;

                                if (status){
                                    var cid = data.responseJSON.message;
                                    $.ajaxFileUpload({
                                        url:"${path}/chapter/upload",
                                        type:"post",
                                        fileElementId: "name",
                                        data:{id:cid,albumId:id},
                                        success:function () {
                                            $("#"+subgrid_table_id).trigger("reloadGrid");
                                        }
                                    })
                                }
                                return "123";
                            }
                        });
                },
                subGridRowColapsed : function(subgrid_id, row_id) {
                    // this function is called before removing the data
                    //var subgrid_table_id;
                    //subgrid_table_id = subgrid_id+"_t";
                    //jQuery("#"+subgrid_table_id).remove();
                }
            });
        $("#albumtable").jqGrid('navGrid', '#albumpage', {
            add : true,
            edit : false,
            del : false,
            search : false
        },
            {},
            {
                closeAfterAdd:true,
                afterSubmit:function (data) {
                    var status = data.responseJSON.status;
                    var message = data.responseJSON.message;
                    if(status){
                        $.ajaxFileUpload({
                            url:"${path}/album/upload",
                            type:"post",
                            fileElementId:"cover",
                            data:{id:message},
                            success:function (response) {
                                $("#albumtable").trigger("reloadGrid");
                            }
                        })
                    }
                    return "123";
                }
            });
    })

</script>



<%--初始化面板--%>
<div class="panel panel-success">
    <%--面板头--%>
    <div class="panel panel-heading">
        <h2>专辑信息</h2>
    </div>

    <ul class="nav nav-tabs">
        <li class="active"><a href="#">专辑信息</a></li>
    </ul>

    <%--初始表单--%>
    <table id="albumtable"/>

    <%--分页工具栏--%>
    <div id="albumpage"/>
</div>