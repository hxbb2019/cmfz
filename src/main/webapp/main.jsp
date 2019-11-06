<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>持名法州后台管理系统</title>
    <link rel="stylesheet" href="${path}/bootstrap/css/bootstrap.css">

    <%--引入jqgrid中主题css样式--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/jqgrid/css/css/hot-sneaks/jquery-ui-1.8.16.custom.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/jqgrid/boot/css/trirand/ui.jqgrid-bootstrap.css"/>
    <%--引入js文件--%>
    <script src="${pageContext.request.contextPath}/bootstrap/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/jqgrid/js/i18n/grid.locale-cn.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/jqgrid/boot/js/trirand/jquery.jqGrid.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/ajaxfileupload.js"></script>
    <%--引入kindeditor的js文件--%>
    <script charset="utf-8" src="${path}/kindeditor/kindeditor-all.js"></script>
    <script charset="utf-8" src="${path}/kindeditor/lang/zh-CN.js"></script>
</head>
<body>
    <%--顶部导航条--%>
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <!-- 导航条标题 -->
            <div class="navbar-header">
                <a class="navbar-brand" href="#">持明法州后台管理系统</a>
            </div>

            <!--  -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">欢迎：<span class="text-primary">小黑</span></a></li>
                    <li class="dropdown">
                        <a href="${path}/admin/logout">退出登录 <span class="glyphicon glyphicon-log-out"></span></a>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <%--栅格系统--%>
    <div class="container-fluid">
        <div class="row">
            <%--左边手风琴部分--%>
            <div class="col-md-2">
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true" align="center">

                    <div class="panel panel-info">
                        <div class="panel-heading" role="tab" id="headingOne">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    轮播图管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked" >
                                    <li><button class="btn btn-info"><a href="javascript:$('#mainId').load('${path}/banner/banner.jsp')">展示轮播图</a></button></li>
                                </ul>

                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="panel panel-success">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    专辑管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><button class="btn btn-success"><a href="javascript:$('#mainId').load('${path}/album/album.jsp')">所有专辑</a></button></li>
                                </ul>

                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="panel panel-danger">
                        <div class="panel-heading" role="tab" id="headingThree">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                    文章管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><button class="btn btn-danger"><a href="javascript:$('#mainId').load('${path}/article/article.jsp')">所有文章</a></button></li>
                                </ul>

                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="panel panel-primary">
                        <div class="panel-heading" role="tab" id="headingFour">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                    明星管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><button class="btn btn-default"><a href="javascript:$('#mainId').load('${path}/star/star.jsp')">所有明星</a></button></li>
                                </ul>

                            </div>
                        </div>
                    </div>

                    <hr>

                    <div class="panel panel-warning">
                        <div class="panel-heading" role="tab" id="headingFive">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                                    用户管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                            <div class="panel-body">
                                <ul class="nav nav-pills nav-stacked">
                                    <li><button class="btn btn-warning"><a href="javascript:$('#mainId').load('${path}/user/user.jsp')">所有用户</a></button></li>
                                </ul>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- 右边内容部分 --%>
            <div class="col-md-10" id="mainId">
                <%--巨幕开始--%>
                    <div class="jumbotron" align="center" >
                        <h2>欢迎来到持明法州后台管理系统</h2>
                    </div>
                <%--右边轮播图部分--%>
                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" align="center">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">
                            <div class="item active">
                                <img src="${path}/bootstrap/img/shouye.jpg" alt="...">
                                <div class="carousel-caption">
                                </div>
                            </div>
                            <div class="item">
                                <img src="${path}/bootstrap/img/1.png" alt="...">
                                <div class="carousel-caption">
                                </div>
                            </div>
                            <div class="item">
                                <img src="${path}/bootstrap/img/2.png" alt="...">
                                <div class="carousel-caption">
                                </div>
                            </div>
                        </div>

                        <!-- Controls -->
                        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>

            </div>
        </div>
    </div>
    <%--页脚--%>
    <div class="panel panel-footer" align="center">
        <div href="">百知教育heixb@zparkhr.com</div>
    </div>

</body>
</html>