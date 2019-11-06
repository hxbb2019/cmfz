<%@page pageEncoding="UTF-8" contentType="text/html; UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script>
    $(function () {
        $("#articletable").jqGrid(
            {
                url : '${path}/article/selectAll',
                datatype : "json",
                colNames : [ '编号', '标题', '作者', '简介', '内容','创建时间','操作'],
                colModel : [
                    {name : 'id',hidden:true},
                    {name : 'title',editable:true},
                    {name : 'author',editable:true},
                    {name : 'brief',editable:true},
                    {name : 'content',hidden:true},
                    {name : 'createDate',editable:true,edittype:"date"},
                    {name : 'operation',formatter:function (value,option,rows) {
                            return "<a class='btn btn-primary' onclick=\"openModal('edit','"+rows.id+"')\">修改</a>"
                            + "&nbsp;&nbsp;&nbsp;<a class='btn btn-danger'>删除</a> ";
                        }}
                ],
                rowNum : 3,
                rowList : [ 3, 5, 10 ],
                pager : '#articlepage',
                viewrecords : true,
                styleUI :"Bootstrap",
                autowidth : true,
                editurl : "someurl.php"
            }).navGrid("#articlepage", {edit : false,add : false,del : false});
    })

    function openModal(oper,id) {

        if("add"==oper){
            $("#article-id").val("");
            $("#article-title").val("");
            $("#article-author").val("");
            $("#article-brief").val("");
            KindEditor.html("#editor_id","")
        }
        if("edit"==oper){
            var article = $("#articletable").jqGrid("getRowData",id);
            $("#article-id").val(article.id);
            $("#article-title").val(article.title);
            $("#article-author").val(article.author);
            $("#article-brief").val(article.brief);
            KindEditor.html("#editor_id",article.content)
        }
        $("#article-modal").modal("show");
    }


    KindEditor.create('#editor_id',{
            width:'560px',
            //点击图片空间按钮时发送的请求
            fileManagerJson:"${path}/article/browse",
            //展示图片空间按钮
            allowFileManager:true,
            //上传图片所对应的方法
            uploadJson:"${path}/article/upload",
            //上传图片名称作为方法的形参名
            filePostName:"articleImg",
            afterBlur:function () {
                this.sync();
            }
    });
    
    function save() {
        var id = $("#article-id").val();
        var url="";
        if(id){
            url="${path}/article/edit";
        }else{
            url="${path}/article/add";
        }
        $.ajax({
            url:url,
            type:"post",
            data:$("#article-form").serialize(),
            datatype:"json",
            success:function () {
                //自动刷新jqgrid表格
                $("#articletable").trigger("reloadGrid");
            }
        })
    }

</script>





<%--初始化面板--%>
<div class="panel panel-primary">
    <%--面板头--%>
    <div class="panel panel-heading">
        <h2>文章信息</h2>
    </div>

    <ul class="nav nav-tabs">
        <li class="active" role="presentation" ><a href="#">所有文章</a></li>
        <li role="presentation"><a href="#" onclick="openModal('add','')">添加文章</a></li>
    </ul>

    <%--初始表单--%>
    <table id="articletable"/>

    <%--分页工具栏--%>
    <div id="articlepage"/>
    <%--模态框--%>
        <div id="article-modal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 683px">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">添加文章</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="article-form">
                            <input type="hidden" name="id" id="article-id">
                            <div class="form-group">
                                <label for="article-title" class="col-sm-2 control-label">文章标题</label>
                                <div class="col-sm-10">
                                    <input type="text" name="title" class="form-control" id="article-title" placeholder="请输入文章标题...">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="article-author" class="col-sm-2 control-label">文章作者</label>
                                <div class="col-sm-10">
                                    <input type="text" name="author" class="form-control" id="article-author" placeholder="请输入文章作者...">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="article-brief" class="col-sm-2 control-label">文章简介</label>
                                <div class="col-sm-10">
                                    <input type="text"  name="brief" class="form-control" id="article-brief" placeholder="请输入文章简介...">
                                </div>
                            </div>
                            <textarea id="editor_id" name="content" style="width:700px;height:300px;">


                            </textarea>

                        </form>


                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" onclick="save()">提交</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
</div>