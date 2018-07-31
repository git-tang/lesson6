<%--
  Created by IntelliJ IDEA.
  User: TangPeng
  Date: 2018/7/30
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
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
                <div class="widget-box  <c:if test="${hasOrders}">collapsed</c:if>" >
                    <div class="widget-header ">
                        <h3 class="widget-title ">
                                <%--<spring:message code="accesslog.title.search"/>--%>
                            修改班级信息
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
                                <form id="form" method="post" action="/student/updategrade.do" class="form-horizontal" role="form" enctype="multipart/form-data">

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.keywords"/>--%>学号 </label>

                                        <div class="col-sm-6">
                                            <input type="hidden" name="id" value="<c:out value="${grade.id}"/>">
                                            <input class=" form-control " value="<c:out value="${grade.name}"/>" type="text" autocomplete="off" name="studentid">
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.keywords"/>--%>姓名 </label>

                                        <div class="col-sm-6">
                                            <input class=" form-control " value="<c:out value="${student.name}"/>" type="text" autocomplete="off" name="name">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.keywords"/>--%>性别 </label>

                                        <div class="col-sm-6">
                                            <input class=" form-control " value="<c:out value="${student.sex}"/>" type="text" autocomplete="off" name="sex">
                                        </div>
                                    </div>


                                    <div class="form-group">

                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.keywords"/>--%>出生日期 </label>
                                        <div class="col-sm-6">
                                            <div class="row">
                                                <div class="col-xs-8 col-sm-11">
                                                    <div class="input-group">
                                                        <input class="form-control date-picker" id="id-date-picker-1" value="<c:out value="${date}"/>" type="text" name="birthday" data-date-format="dd-mm-yyyy" />
                                                        <span class="input-group-addon">
																		<i class="fa fa-calendar bigger-110"></i>
																	</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.keywords"/>--%>头像 </label>

                                        <div class="col-sm-6">
                                            <input class=" form-control " value="<c:out value="${student.img}"/>" type="file"  name="img">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label no-padding-right"><%--<spring:message code="accesslog.keywords"/>--%>班级 </label>

                                        <div class="col-sm-6">

                                            <select class="form-control" id="form-field-select-1" name="grade">
                                                <c:forEach items="${grades}" var="grade">
                                                    <option value="${grade.id}">${grade.name}</option>
                                                    <%--<option value="AL"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">阿拉巴马</font></font></option>--%>
                                                </c:forEach>
                                            </select>
                                        </div>

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



                                    <div class="col-sm-12 space-10"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="space-2">

                </div>




            </div>
        </div>
        <!-- /.modal -->
        <script>

            jQuery(function($) {

                //datepicker plugin
                //link
                $('.date-picker').datepicker({
                    autoclose: true,
                    todayHighlight: true
                })
                //show datepicker when clicking on the icon
                    .next().on(ace.click_event, function(){
                    $(this).prev().focus();
                });


            });
        </script>
    </jsp:body>
</lesson:page>