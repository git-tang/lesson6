<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="lesson" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="lessonTag" uri="http://com.biz.lesson/tag/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<lesson:page title="accesslog.title.search">

    <jsp:attribute name="script">
		<script src="static-resource/ace/assets/js/moment.min.js"></script>
		<script src="static-resource/ace/assets/js/bootstrap-datepicker.min.js"></script>
		<script src="static-resource/ace/assets/js/daterangepicker.min.js"></script>
        <script src="static-resource/ace/assets/js/bootstrap-clockpicker.min.js"></script>
		<script src="static-resource/ace/assets/js/bootstrap-multiselect.min.js"></script>

        <script type="text/javascript">
            $(function () {
                $('#dateRangePicker').daterangepicker({
                    autoUpdateInput: false,
                    "autoApply": false,
                    locale: {
                        format: 'YYYY-MM-DD'
                    }
                }, function (start, end) {
                    var startDate = start.format("YYYY-MM-DD");
                    var endDate = end.format("YYYY-MM-DD");
                    $("#startTime").val(startDate);
                    $("#endTime").val(endDate);
                    $("#dateRangePicker").val(startDate + " - " + endDate);
                }).on('cancel.daterangepicker', function (ev, picker) {
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
        <c:set var="hasOrders" value="false"/>
        <div class="row">

            <div class="col-xs-12">
                <div class="widget-box  <c:if test="${hasOrders}">collapsed</c:if>">
                    <div class="widget-header ">
                        <h3 class="widget-title ">
                                <%--<spring:message code="accesslog.title.search"/>--%>
                            选课
                        </h3>
                        <div class=" widget-toolbar no-border " style="margin-right: 30px">
                            <a data-action="collapse">
                                <i class="ace-icon fa ${hasOrders ? "fa-chevron-down":"fa-chevron-up"}"></i>
                            </a>
                        </div>
                    </div>

                    <div class="widget-body">

                        <div class="widget-main padding-6 no-padding-left no-padding-right">
                            <label class="col-sm-3 control-label no-padding-right">已选学科</label>

                            <table id="simple-table" class="table tables table-nonfluid table-bordered table-hover">
                                <thead>
                                <tr>

                                    <th><%--<spring:message code="accesslog.user"/>--%></th>

                                    <th><%--<spring:message code="accesslog.uri"/>--%>学科名</th>
                                    <th><%--<spring:message code="accesslog.uri"/>--%>分数</th>
                                    <th><%--<spring:message code="accesslog.user"/>--%></th>

                                </tr>
                                </thead>

                                <tbody>

                                <c:forEach items="${student.marks}" var="mark">
                                    <tr>

                                        <th><%--<spring:message code="accesslog.user"/>--%></th>
                                        <th><%--<spring:message code="accesslog.timestamp"/>--%><c:out
                                                value="${mark.name}"></c:out></th>
                                        <th><%--<spring:message code="accesslog.uri"/>--%><c:out
                                                value="${mark.score}"></c:out></th>
                                        <th><%--<spring:message code="accesslog.uri"/>--%></th>

                                    </tr>

                                </c:forEach>
                                </tbody>
                            </table>


                        </div>

                    </div>

                </div>
                <div class="widget-header padding-6 no-padding-left no-padding-right">
                    <%--<div class="widget-header ">
                    <label class="col-sm-3 control-label no-padding-right">选科</label>
                    <form action="/student/xuanke.do">
                    <div class="col-xs-12 col-sm-5">

                            &lt;%&ndash;<label class="control-label bolder blue"><font style="vertical-align: inherit;"><font
                                    style="vertical-align: inherit;">复选框</font></font></label>
&ndash;%&gt;                        <input type="hidden" name="id" value="<c:out value="${student.id}"></c:out>"/>

                                <table id="" class="table tables table-nonfluid table-bordered table-hover">
                                    <thead>
                                    <tr>

                                        <th>&lt;%&ndash;<spring:message code="accesslog.user"/>&ndash;%&gt;</th>

                                        <th>&lt;%&ndash;<spring:message code="accesslog.uri"/>&ndash;%&gt;学科名</th>
                                        <th>&lt;%&ndash;<spring:message code="accesslog.uri"/>&ndash;%&gt;选择</th>
                                        <th>&lt;%&ndash;<spring:message code="accesslog.user"/>&ndash;%&gt;</th>

                                    </tr>
                                    </thead>

                                    <tbody>
                                    <c:forEach items="${subjects}" var="subject">

                                        <tr>

                                            <th>&lt;%&ndash;<spring:message code="accesslog.user"/>&ndash;%&gt;</th>
                                            <th><div class="checkbox">
                                                <label>
                                                    <input name="subs" type="checkbox" class="ace" value="<c:out value="${subject.name}"></c:out>">
                                                    <span class="lbl"><font style="vertical-align: inherit;"><font
                                                            style="vertical-align: inherit;"> </font></font></span>
                                                </label>

                                            </div></th>
                                            <th><span class="lbl"><font style="vertical-align: inherit;" ><font
                                                    style="vertical-align: inherit;"> <c:out value="${subject.name}"></c:out></font></font></span></th>
                                            <th>&lt;%&ndash;<spring:message code="accesslog.uri"/>&ndash;%&gt;</th>

                                        </tr>

                                    </c:forEach>
                                    </tbody>
                                </table>

                    </div>
                    <div class="col-sm-12">
                        <div class="clearfix ">
                            <div class="text-center">
                                &nbsp; &nbsp; &nbsp;
                                <button class="btn btn-primary btn-info" type="submit">
                                    <spring:message code="提交" />
                                </button>


                            </div>
                        </div>
                    </div>
                    </form>
                </div>--%>
                    <form action="/student/xuanke.do" name="form1" onSubmit="return myCheck()">
                    <div class="widget-body">
                        <input type="hidden" name="id" value="<c:out value="${student.id}"></c:out>"/>
                        <div class="widget-main padding-6 no-padding-left no-padding-right">
                            <label class="col-sm-3 control-label no-padding-right">选科</label>

                            <table id="" class="table tables table-nonfluid table-bordered table-hover">
                                <thead>
                                <tr>

                                    <th><%--<spring:message code="accesslog.user"/>--%></th>

                                    <th><%--<spring:message code="accesslog.uri"/>--%>学科名</th>
                                    <th><%--<spring:message code="accesslog.uri"/>--%>选择</th>
                                    <th><%--<spring:message code="accesslog.user"/>--%></th>

                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach items="${subjects}" var="subject">

                                    <tr>

                                        <th><%--<spring:message code="accesslog.user"/>--%></th>
                                        <th><div class="checkbox">
                                            <label>
                                                <input name="subs" type="checkbox" class="ace" value="<c:out value="${subject.name}"></c:out>">
                                                <span class="lbl"><font style="vertical-align: inherit;"><font
                                                        style="vertical-align: inherit;"> </font></font></span>
                                            </label>

                                        </div></th>
                                        <th><span class="lbl"><font style="vertical-align: inherit;" ><font
                                                style="vertical-align: inherit;"> <c:out value="${subject.name}"></c:out></font></font></span></th>
                                        <th><%--<spring:message code="accesslog.uri"/>--%></th>

                                    </tr>

                                </c:forEach>

                            </table>


                        </div>
                        <div class="col-sm-12">
                            <div class="clearfix ">
                                <div class="text-center">
                                    &nbsp; &nbsp; &nbsp;
                                    <button class="btn btn-primary btn-info" type="submit">
                                        <spring:message code="提交" />
                                    </button>


                                </div>
                            </div>
                        </div>
                    </div>
                    </form>
            </div>
        </div>

        <div class="space-2">

        </div>


        </div>
        </div>
        <!-- /.modal -->

    </jsp:body>
</lesson:page>