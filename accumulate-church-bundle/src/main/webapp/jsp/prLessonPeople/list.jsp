<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/14
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>签到情况</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />

    <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap-theme.css"/>
    <script type="text/javascript" src="/resources/static/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/resources/static/bootstrap-3.3.7/js/bootstrap.js"></script>
</head>
<body>
    <div class="container">
        <div class="row clearfix">
            <div class="col-md-12 column">

                <div class="container-fluid" style="margin-top: 10px">
                    <div class="row-fluid">
                        <div class="span12">
                            <h4 class="text-center">
                                <fmt:formatDate value="${lesson.worshipDate}" pattern="yyyy-MM-dd"/>
                                &nbsp;
                                签到情况
                            </h4>
                        </div>
                    </div>
                </div>

                <div style="margin-top: 10px">
                    <ul class="nav nav-tabs">
                        <c:forEach items="${prLessonPeopleList}" var="item" varStatus="status">
                            <li style="width: 25%;height: 120px;" id="li-${item.peopleId}">
                                <div class="text-center people-head">
                                    <img src="${item.headBase64}" width="70" height="80" class="img-rounded center-block" onclick="signName(${lessonPeopleQuery.lessonId},${item.peopleId},'${item.peopleName}')">
                                </div>
                                <div class="text-center people-name" style="color: ${item.isSign() ? 'blue' : 'red'}">
                                    <label>${item.peopleName}</label>
                                </div>
                            </li>
                        </c:forEach>

                        <%--新增按钮--%>
                        <li style="width: 25%;height: 120px;">
                            <div style="text-align:center;">
                                <a href="javascript:;" onclick="addPeople()">
                                    <img src="/resources/static/image/icon-add.png" class="img-rounded center-block" width="70" height="80">
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>

            </div>
        </div>

        <%-- 添加人员遮罩层 start--%>
        <div id="modal-container-addPeople" role="dialog" class="modal fade" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title" id="myModalLabel">
                            添加人员
                        </h4>
                    </div>
                    <div class="modal-body">
                        <form role="form" id="savePeopleForm" method="post">
                            <input type="hidden" id="parishId" name="parishId" value="${lesson.parishId}"/>
                            <div class="form-group">
                                <label for="name" class="col-sm-2 control-label">姓名</label>
                                <div class="col-sm-10">
                                    <input type="text"  name="name" id="name" class="form-control" value="" placeholder="请输入姓名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="mobile" class="col-sm-2 control-label">手机号</label>
                                <div class="col-sm-10">
                                    <input id="mobile" name="mobile" class="form-control" type="text" value="" placeholder="请输入手机号"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="gender" class="col-sm-2 control-label">性别</label>
                                <div class="col-sm-10">
                                    <select id="gender" name="gender" class="custom-select" style="width:200px">
                                        <c:forEach items="${GenderEnumArr}" var="gender" varStatus="sta">
                                            <option value="${gender.status}">${gender.value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="ageGroup" class="col-sm-2 control-label">年龄段</label>
                                <div class="col-sm-10">
                                    <select id="ageGroup" name="ageGroup" class="custom-select" style="width:200px">
                                        <option value="0">请选择</option>
                                        <c:forEach items="${AgeGroupEnumArr}" var="age" varStatus="sta">
                                            <option value="${age.status}">${age.value}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="birthday" class="col-sm-2 control-label">生日</label>
                                <div class="col-sm-10">
                                    <input id="birthday" name="birthday" class="form-control" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="" placeholder="请输入生日"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="sort" class="col-sm-2 control-label">排序</label>
                                <div class="col-sm-10">
                                    <input id="sort" name="sort" class="form-control" type="text" value="" placeholder="请输入排序"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="remark" class="col-sm-2 control-label">备注</label>
                                <div class="col-sm-10">
                                    <input id="remark" name="remark" class="form-control" type="text" value="" placeholder="请输入备注"/>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" onclick="savePeople()">保存</button>
                    </div>
                </div>
            </div>
        </div>
        <%--遮罩层  end--%>

    </div>
</body>

<script type="text/javascript">

    function signName(lessonId, peopleId, peopleName) {
        if (!lessonId || !peopleId) {
            alert("参数不正确");
            return false;
        }

        $.ajax({
            type: "POST",
            url: "/prLessonPeople/getByLessonPeople",
            data: {"lessonId":lessonId, "peopleId":peopleId}, // "status":1
            dataType: "json",
            async: false,
            success: function (data) {
                var resultObj = eval(data);
                if (resultObj.code == "true") {
                    if(confirm("[ "+peopleName+" ] 确定取消签到？")){
                        insertOrDelete(lessonId, peopleId, false);
                    }

                } else {
                    if(confirm("[ "+peopleName+" ] 确定签到？")){
                        insertOrDelete(lessonId, peopleId, true);
                    }
                }
            }
        });
    }

    function insertOrDelete(lessonId, peopleId, flag){
        var url = "/prLessonPeople/insert";
        if(!flag){
            url = "/prLessonPeople/delete";
        }

        $.ajax({
            type: "POST",
            url: url,
            data: {"lessonId":lessonId, "peopleId":peopleId},
            dataType: "json",
            async: false,
            success: function (data) {
                var resultObj = eval(data);
                if (resultObj.code == "true") {
                    //window.location.reload();
                    if(flag){ // 签到
                        //alert("签到成功");
                        $("#li-"+peopleId).children("div.people-name").css("color","blue");
                    }else { // 取消签到
                        //alert("取消签到成功");
                        $("#li-"+peopleId).children("div.people-name").css("color","red");
                    }

                } else {
                    alert("操作失败. " + resultObj.message);
                }
            }
        });
    }


    function addPeople(){
        $("#myModalLabel").html("添加人员");
        $("#modal-container-addPeople").modal('show');
        return false;
    }

    function savePeople(){
        var formValues = $("#savePeopleForm").serialize();
        if(confirm("确认保存吗？")){
            $.ajax({
                url: "/churchPeople/addOrUpdate",
                type: "POST",
                data: formValues,
                dataType: "json",
                success: function (returnData) {
                    var resultObj = eval(returnData);
                    if (resultObj.code == "true") {
                        $('#modal-container-addPeople').modal('hide');
                        location.reload(true);
                    }else{
                        alert(resultObj.message);
                    }
                }
            });
        }
    }


</script>
</html>


