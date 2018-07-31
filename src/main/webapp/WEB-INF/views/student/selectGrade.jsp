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
                            班级信息管理
                        </h3>
                        <div class=" widget-toolbar no-border " style="margin-right: 30px">
                            <%--<a  data-action="collapse">
                                <i class="ace-icon fa ${hasOrders ? "fa-chevron-down":"fa-chevron-up"}"></i>
                            </a>--%>
                        </div>
                    </div>

                </div>

                <div class="space-2">

                </div>

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
                                <span class="hidden-sm hidden-xs btn-group pull-right">
                                <form action="/student/addgrade.do" name="form1" onSubmit="return myCheck()">

                                    <input value="" name="name" class="col-xs-10 col-sm-5" placeholder="班级名"/>

                                    <button class="btn btn-mini btn-yellow" type="submit">
                                        <spring:message code="添加班级" />
                                    </button>
                                </form>


                            </span>
                                <div>
                                    <table id="simple-table" class="table tables table-nonfluid table-bordered table-hover" >
                                        <thead>
                                        <tr>
                                            <th class="detail-col"></th>
                                            <th><%--<spring:message code="accesslog.user"/>--%>序号</th>
                                            <th><%--<spring:message code="accesslog.timestamp"/>--%>班级名</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>人数</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>平均分</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>修改班级名</th>
                                            <th><%--<spring:message code="accesslog.uri"/>--%>删除</th>


                                        </tr>
                                        </thead>

                                        <tbody>

                                        <c:forEach items="${grades}" var="grade">
                                            <tr>
                                                <td class="center">
                                                        <%--<c:if test="${not empty student.studentid}">--%>
                                                    <div class="action-buttons">
                                                        <a href="#" class="green bigger-140 show-details-btn">
                                                            <i class="ace-icon fa fa-angle-double-down"></i>

                                                        </a>
                                                    </div>
                                                        <%--</c:if>--%>
                                                </td>
                                                <th><%--<spring:message code="accesslog.user"/>--%><c:out value="${grade.id}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.timestamp"/>--%><c:out value="${grade.name}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><c:out value="${grade.students.size()}"></c:out></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><c:out value="${grade.avgscore}"></c:out></th>

<%--
                                                <th><a href="/student/daoupdategrade.do?id=${grade.id}"><i class="ace-icon fa fa-pencil bigger-120"></i></a></th>
--%>
                                                <th><form action="/student/updategrade.do" name="form1" onSubmit="return myCheck()">
                                                    <input type="hidden" value="${grade.id}" name="id"/>
                                                    <input value="${grade.name}" name="name" class="col-xs-10 col-sm-5"/>

                                                    <button class="btn btn-mini btn-yellow" type="submit">
                                                        <spring:message code="修改" />
                                                    </button>
                                                </form></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><a href="/student/deletegrade.do?id=${grade.id}"><i class="ace-icon fa fa-trash-o bigger-120"></i></a></th>

                                            </tr>
                                            <tr class="detail-row">
                                                <td colspan="13">
                                                    <!------------------------------------------>
                                                    <%--<div class="table-detail">
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-2">
                                                                <div class="text-center">
                                                                    <img height="150" class="thumbnail inline no-margin-bottom" alt="Domain Owner's Avatar"
                                                                         src="https://file-img.oss-cn-beijing.aliyuncs.com/${student.img}">
                                                                    <br>
                                                                    <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                                                                        <div class="inline position-relative">
                                                                                &lt;%&ndash;<a class="user-title-label" href="#">&ndash;%&gt;
                                                                            <i class="ace-icon fa fa-circle light-green"></i>
                                                                            &nbsp;
                                                                            <span class="white"><c:out value="${student.name}"></c:out></span>
                                                                                &lt;%&ndash;</a>&ndash;%&gt;
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
                                                                                <c:out value="${mark.name}  "></c:out>
                                                                                <c:out value="${mark.score}  "></c:out>
                                                                            </c:forEach></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>--%>


                                                        <table>
                                                            <tr>
                                                                <td style="width: 100px;align-content: center">姓名</td>
                                                                <td>平均分</td>
                                                            </tr>
                                                            <c:forEach items="${grade.students}" var="student">
                                                            <tr>
                                                                <td><c:out value="${student.name}"></c:out></td>
                                                                <td><c:out value="${student.avgscore}"></c:out></td>
                                                            </tr>
                                                            </c:forEach>
                                                        </table>




                                                    <!------------------------------------------------------>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <%--<lesson:springPagePagination url="student/selectstudent.do?page=${page}"  springPage="${allStudent}"/>--%>

                                </div>
                            </div>

                        </div>

                    </div>
                </div>


            </div>
        </div>
        <!-- /.modal -->
        <!-------------------->





        <!----------------->
    </jsp:body>
</lesson:page>