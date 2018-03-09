<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/14
  Time: 14:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>名单</title>

    <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap-theme.css"/>

    <script type="text/javascript" src="/resources/static/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/resources/static/js/lrz/lrz.bundle.js"></script>
</head>
<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <form class="form-horizontal" role="form" id="saveForm" method="post" action="/churchPeople/update">
                <input id="id" name="id" value="${churchPeople.id}" type="hidden"/>
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-10">
                        <input type="text"  name="name" id="name" class="form-control" value="${churchPeople.name}" placeholder="请输入姓名">
                    </div>
                </div>
                <div class="form-group">
                    <label for="mobile" class="col-sm-2 control-label">手机号</label>
                    <div class="col-sm-10">
                        <input id="mobile" name="mobile" class="form-control" type="text" value="${churchPeople.mobile}" placeholder="请输入手机号"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="gender" class="col-sm-2 control-label">性别</label>
                    <div class="col-sm-10">
                        <select id="gender" name="gender" class="custom-select">
                            <c:forEach items="${GenderEnumArr}" var="gender" varStatus="sta">
                                <option value="${gender.status}" <c:if test="${churchPeople.gender == gender.status}">selected</c:if>>${gender.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="birthday" class="col-sm-2 control-label">生日</label>
                    <div class="col-sm-10">
                        <input id="birthday" name="birthday" class="form-control" type="text" value="${churchPeople.birthday}" placeholder="请输入生日"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="sort" class="col-sm-2 control-label">排序</label>
                    <div class="col-sm-10">
                        <input id="sort" name="sort" class="form-control" type="text" value="${churchPeople.sort}" placeholder="请输入排序"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="parishId" class="col-sm-2 control-label">分堂</label>
                    <div class="col-sm-10">
                        <select id="parishId" name="parishId" class="custom-select">
                            <option value="${churchParish.id}">${churchParish.name}</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remark" class="col-sm-2 control-label">备注</label>
                    <div class="col-sm-10">
                        <input id="remark" name="remark" class="form-control" type="text" value="${churchPeople.remark}" placeholder="请输入备注"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="headUpload" class="col-sm-2 control-label">头像</label>
                    <div class="col-sm-10">
                        <input id="headUpload" type="file" accept="image/*" style="width: 200px"/>
                        <img src="${churchPeople.headBase64}" width="140" height="160"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <a href="javascript:void(0);" class="btn btn-default" onclick="save();">保存</a>
                        <a href="/churchPeople/list" class="btn btn-default">取消</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    var _contextPath = "<%=request.getContextPath()%>";

    $("#headUpload").on("change", function () {
        var inputFile = this;
        lrz(inputFile.files[0],{
            width:210,
            height:240,
            quality:1,
            fieldName:'img'
        }).then(function (rst) {
                // 处理成功会执行
                if (rst.fileLen>512000){ // 500K
                    alert("上传图片大小超过最大限制");
                }else{
                    var id = $("#id").val();
                    if(!id){
                        alert("id为空");
                        return false;
                    }

                    // ------------------------------------------------------------------
                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', _contextPath+"/churchPeople/uploadHeadPortrait");
                    xhr.onload = function () {
                        if (xhr.status === 200) {
                            var data = eval("(" + xhr.responseText + ")");
                            if (data.code == "true"){
                                $(inputFile).parent().find("img").attr("src",rst.base64);

                            }else{
                                alert(data.message);
                            }
                        }else{
                            alert("上传失败,响应代码:"+xhr.status);
                        }
                    };
                    xhr.onerror = function () {
                        // 处理错误
                    };
                    //额外添加参数
                    rst.formData.append('id', id);
                    //rst.formData.append('fileLen', rst.fileLen);
                    // 触发上传
                    xhr.send(rst.formData);
                    // ------------------------------------------------------------------

                }
            })
            .catch(function (err) {
                // 处理失败会执行
                alert("上传失败。"+err);
            })
            .always(function () {
                // 不管是成功失败，都会执行
            });
    });

    function save() {
        var dataObj = {};
        dataObj.id = $("#id").val();
        dataObj.name = $("#name").val();
        dataObj.mobile = $("#mobile").val();
        dataObj.gender = $("#gender").val();
        //dataObj.birthday = $("#birthday").val();
        dataObj.sort = $("#sort").val();
        dataObj.parishId = $("#parishId").val();
        dataObj.remark = $("#remark").val();
        if (!dataObj.name) {
            alert("姓名必填");
            return false;
        }

        var url = "/churchPeople/add";
        if(dataObj.id && dataObj.id>0){
            url = "/churchPeople/update";
        }
        $.ajax({
            type: "POST",
            url: url,
            data: dataObj,
            dataType: "json",
            async: false,
            success: function (data) {
                var resultObj = eval(data);
                if (resultObj.code == "true") {
                    alert("操作成功");
                    window.location.href = "/churchPeople/list";
                } else {
                    alert("操作失败. " + resultObj.message);
                }
            }
        });
    }

</script>
</html>


