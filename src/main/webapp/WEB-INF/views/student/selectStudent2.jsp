<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="lesson" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="lessonTag" uri="http://com.biz.lesson/tag/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<lesson:page title="查询学生信息">

    <jsp:attribute name="script">
		<script src="static-resource/ace/assets/js/moment.min.js"></script>
		<script src="static-resource/ace/assets/js/bootstrap-datepicker.min.js"></script>
		<script src="static-resource/ace/assets/js/daterangepicker.min.js"></script>
        <script src="static-resource/ace/assets/js/bootstrap-clockpicker.min.js"></script>
		<script src="static-resource/ace/assets/js/bootstrap-multiselect.min.js"></script>

        <script type="text/javascript">
            $(function(){
                $('#dateRangePicker').daterangepicker({
                    autoUpdateInput:false,
                    "autoApply": false,
                    locale: {
                        format: 'YYYY-MM-DD'
                    }
                },function(start, end) {
                    var startDate = start.format("YYYY-MM-DD");
                    var endDate = end.format("YYYY-MM-DD");
                    $("#startTime").val(startDate);
                    $("#endTime").val(endDate);
                    $("#dateRangePicker").val(startDate + " - " + endDate);
                }).on('cancel.daterangepicker', function(ev, picker) {
                    $("#startTime").val("");
                    $("#endTime").val("");
                    $("#dateRangePicker").val("");
                });
            });
        </script>
        <script type="text/javascript">
            function myCheck()
            {
                for(var i=0;i<document.form1.elements.length-1;i++)
                {
                    if(document.form1.elements[i].value=="")
                    {
                        alert("当前表单不能有空项");
                        document.form1.elements[i].focus();
                        return false;
                    }
                }
                return true;

            }
        </script>
    </jsp:attribute>

    <jsp:attribute name="css">
        <link rel="stylesheet" href="static-resource/ace/assets/css/bootstrap-datepicker3.min.css"/>
		<link rel="stylesheet" href="static-resource/ace/assets/css/daterangepicker.min.css"/>
        <link rel="stylesheet" href="static-resource/ace/assets/css/bootstrap-clockpicker.min.css"/>
        <style type="text/css">
        </style>
    </jsp:attribute>

    <jsp:body>
        <c:set var="hasOrders" value="false"/>
        <div class="row">

            <div class="col-xs-12">
                <div class="widget-box  <c:if test="${hasOrders}">collapsed</c:if>" >
                    <div class="widget-header ">
                        <h3 class="widget-title ">
                            <%--<spring:message code="accesslog.title.search"/>--%>
                            学生信息查询
                        </h3>
                        <div class=" widget-toolbar no-border " style="margin-right: 30px">
                            <a  data-action="collapse">
                                <i class="ace-icon fa ${hasOrders ? "fa-chevron-down":"fa-chevron-up"}"></i>
                            </a>
                        </div>
                    </div>
                    <div class="widget-body">
                        <div class="row">
                            <div class="widget-main">
                                <form id="form" name="form1" method="get" action="student/sousuo.do" class="form-horizontal" role="form" onSubmit="return myCheck()">


                                <div class="form-group">
                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.keywords"/>--%>学号（前缀匹配） </label>

                                        <div class="col-sm-6">
                                            <input type="hidden" name="page" value="0">
                                            <input class=" form-control " value="" type="text" autocomplete="off" name="studentid">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.keywords"/>--%>姓名（模糊匹配） </label>

                                        <div class="col-sm-6">
                                            <input class=" form-control " value="" type="text" autocomplete="off" name="name">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.timestamp"/>--%> 出生日期（时间段）</label>

                                        <div class="col-sm-6">
                                            <div class="row">
                                                <div class="col-xs-12 col-sm-12">
                                                    <div class="input-group">
                                                            <span class="input-group-addon">
                                                                <i class="fa fa-calendar bigger-110"></i>
                                                            </span>
                                                        <input class="form-control" type="text" autocomplete="off" id="dateRangePicker" <c:if test="${not empty vo.startTime and not empty vo.endTime}">value='<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.startTime}"/> - <fmt:formatDate pattern="yyyy-MM-dd" value="${vo.endTime}"/>'</c:if>>
                                                        <input type="hidden" name="startdate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.startTime}"/>" id="startTime">
                                                        <input type="hidden" name="enddate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${vo.endTime}"/>" id="endTime">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-12">
                                        <div class="clearfix ">
                                            <div class="text-center">
                                                &nbsp; &nbsp; &nbsp;
                                                <button class="btn btn-primary btn-sm" type="submit" >
                                                    <spring:message code="button.search"/>
                                                </button>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 space-10"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="space-2"></div>

                <div class="widget-box   widget-color-blue2 " >
                    <div class="widget-header ">
                        <h3 class="widget-title lighter">

                        </h3>
                        <div class=" widget-toolbar no-border " style="margin-right: 30px">
                            <a href="#" data-action="collapse">
                                <i class="ace-icon fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main padding-6 no-padding-left no-padding-right">
                            <div class="ui-widget-content">
                                <div>
                                    <table id="simple-table" class="table tables table-nonfluid table-bordered table-hover" >
                                        <thead>
                                        <tr>
                                            <th class="detail-col"></th>
                                            <th><%--<spring:message code="accesslog.user"/>--%>序号</th>
                                            <th><%--<spring:message code="accesslog.timestamp"/>--%>学号</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>姓名</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>性别</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>出生日期</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>所在班级</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>选修科目数</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>平均分</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>分数录入</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>选课</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>修改</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>删除</th>

                                        </tr>
                                        </thead>

                                        <tbody>

                                        <c:forEach items="${students}" var="student">
                                            <tr>
                                                <td class="center">
                                                    <c:if test="${not empty student.studentid}">
                                                        <div class="action-buttons">
                                                            <a href="#" class="green bigger-140 show-details-btn">
                                                                <i class="ace-icon fa fa-angle-double-down"></i>

                                                            </a>
                                                        </div>
                                                    </c:if>
                                                </td>
                                                <th><%--<spring:message code="accesslog.user"/>--%><c:out value="${student.id}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.timestamp"/>--%><c:out value="${student.studentid}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><c:out value="${student.name}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><c:out value="${student.sex}"></c:out></th>
                                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${student.birthday}"/></td>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><c:out value="${student.grade.name}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><c:out value="${student.marks.size()}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><c:out value="${student.avgscore}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><a href="student/daoaddmark.do?id=${student.id}"><i class="ace-icon fa  bigger-120">录入成绩</i></a></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><a href="student/daoxuanke.do?id=${student.id}"><i class="ace-icon fa  bigger-120">选课</i></a></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><a href="student/daoupdate.do?id=${student.id}"><i class="ace-icon fa fa-pencil bigger-120"></i></a></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><a href="student/deletestudent.do?id=${student.id}&page=${page}"><i class="ace-icon fa fa-trash-o bigger-120"></i></a></th>

                                            </tr>
                                            <tr class="detail-row">
                                                <td colspan="13">
                                                <!------------------------------------------>
                                                    <div class="table-detail">
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-2">
                                                                <div class="text-center">
                                                                    <img height="150" class="thumbnail inline no-margin-bottom" alt="Domain Owner's Avatar" src="https://file-img.oss-cn-beijing.aliyuncs.com/${student.img}">
                                                                    <br>
                                                                    <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                                                                        <div class="inline position-relative">
                                                                            <a class="user-title-label" href="#">
                                                                                <i class="ace-icon fa fa-circle light-green"></i>
                                                                                &nbsp;
                                                                                <span class="white"><c:out value="${student.name}"></c:out></span>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-xs-12 col-sm-7">
                                                                <div class="space visible-xs"></div>

                                                                <div class="profile-user-info profile-user-info-striped">
                                                                    <div class="profile-info-row">
                                                                        <div class="profile-info-name"> 姓名 </div>

                                                                        <div class="profile-info-value">
                                                                            <span><c:out value="${student.name}"></c:out></span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="profile-info-row">
                                                                        <div class="profile-info-name"> 学号 </div>

                                                                        <div class="profile-info-value">

                                                                            <span><c:out value="${student.studentid}"></c:out></span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="profile-info-row">
                                                                        <div class="profile-info-name"> 性别 </div>

                                                                        <div class="profile-info-value">
                                                                            <span><c:out value="${student.sex}"></c:out></span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="profile-info-row">
                                                                        <div class="profile-info-name"> 出生日期 </div>

                                                                        <div class="profile-info-value">
                                                                            <span><fmt:formatDate pattern="yyyy-MM-dd" value="${student.birthday}"/></span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="profile-info-row">
                                                                        <div class="profile-info-name">班级 </div>

                                                                        <div class="profile-info-value">
                                                                            <span><c:out value="${student.grade.name}"></c:out></span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="profile-info-row">
                                                                        <div class="profile-info-name"> 选修科目及分数 </div>

                                                                        <div class="profile-info-value">
                                                                            <span><c:forEach items="${student.marks}" var="mark">
                                                                                <c:out value="学科名：${mark.name}    "></c:out>
                                                                                <c:out value="得分：${mark.score}       "></c:out>
                                                                            </c:forEach></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <%--<div class="col-xs-12 col-sm-3">
                                                                <div class="space visible-xs"></div>
                                                                <h4 class="header blue lighter less-margin">Send a message to Alex</h4>

                                                                <div class="space-6"></div>

                                                                <form>
                                                                    <fieldset>
                                                                        <textarea class="width-100" resize="none" placeholder="Type something…"></textarea>
                                                                    </fieldset>

                                                                    <div class="hr hr-dotted"></div>

                                                                    <div class="clearfix">
                                                                        <label class="pull-left">
                                                                            <input type="checkbox" class="ace">
                                                                            <span class="lbl"> Email me a copy</span>
                                                                        </label>

                                                                        <button class="pull-right btn btn-sm btn-primary btn-white btn-round" type="button">
                                                                            Submit
                                                                            <i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
                                                                        </button>
                                                                    </div>
                                                                </form>
                                                            </div>--%>
                                                        </div>
                                                    </div>



                                                    <!------------------------------------------------------>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <lesson:springPagePagination url="student/sousuo.do?page=${page}"  springPage="${allStudent}"/>

                                </div>
                            </div>

                        </div>

                    </div>
                </div>


            </div>
        </div>
        <!-- /.modal -->

    </jsp:body>
</lesson:page>