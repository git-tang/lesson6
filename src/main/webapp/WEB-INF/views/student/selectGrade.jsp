<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="lesson" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="lessonTag" uri="http://com.biz.lesson/tag/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<lesson:page title="班级管理">

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

        <script type="text/javascript">
        function check()
        {
            var name = document.getElementById("name");
            var errStr = "";
            alert("dasdsadsa");
            if (name.value == "" || name.value == null)
            {
                errStr += "表单不能为空\n";
            }

            alert(errStr);
            return false;
        }
        document.getElementById("regForm").onsubmit = check;

        function check2()
        {

            var name2 = document.getElementById("name2").value;
            if ( name2 = "" || name2 == null)
            {
                alert("表单不能为空\n");return false;
            }


            return true;
        }
        /*document.getElementById("regForm2").onsubmit = check2;*/
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
                                <form action="student/addgrade.do" id="regForm" name="form1" onSubmit="return myCheck()">

                                    <input value="" id="name" name="name" class="col-xs-10 col-sm-5" placeholder="班级名"/>

                                    <button class="btn btn-mini btn-yellow" type="submit" >
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
                                                <th><form action="student/updategrade.do"  id="regForm2" name="form1" onSubmit="return check2()">

                                                    <input  id="name2" value="${grade.name}"  name="name" class="col-xs-10 col-sm-5"/>
                                                    <input  type="hidden" value="${grade.id}" name="id"/>
                                                    <button class="btn btn-mini btn-yellow" type="submit">
                                                        <spring:message code="修改" />
                                                    </button>
                                                </form></th>
                                                <th><%--<spring:message code="accesslog.uri"/>--%><a href="student/deletegrade.do?id=${grade.id}"><i class="ace-icon fa fa-trash-o bigger-120"></i></a></th>

                                            </tr>
                                            <tr class="detail-row">
                                                <td colspan="13">
                                                    <!------------------------------------------>



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