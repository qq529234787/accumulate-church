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
  <title>敬拜名单</title>
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1,user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="format-detection" content="telephone=no" />
  <meta name="format-detection" content="email=no" />

  <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap.css"/>
  <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap-theme.css"/>
  <script type="text/javascript" src="/resources/static/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="/resources/static/bootstrap-3.3.7/js/bootstrap.js"></script>
  <script type="text/javascript" src="/resources/static/My97DatePicker/WdatePicker.js"></script>
  <script type="text/javascript" src="/resources/static/js/lrz/lrz.bundle.js"></script>
</head>

<body>
  <div class="container">
    <div class="row clearfix">
      <div class="col-md-12 column">

        <div class="container-fluid" style="margin-top: 10px">
          <div class="row-fluid">
            <div class="span12">
              <h4 class="text-center">
                ${parish.name}
              </h4>
            </div>
          </div>
        </div>

        <div style="margin-top: 10px">
          <ul class="nav nav-tabs">
            <c:forEach items="${stablePeoples}" var="item" varStatus="status">
              <li style="width: 25%;height: 120px;">
                <div class="text-center">
                  <div>
                    <ul class="nav nav-tabs">
                      <li style="width: 50%;height: 1px;float: left">

                      </li>
                      <li style="width: 50%;height: 1px;float: right">
                        <img src="/resources/static/image/icon-del0.png" width="20" height="20" onclick="changeStatus(${item.id},'${item.name}','delete')">
                      </li>
                    </ul>
                  </div>
                  <img src="${item.headBase64}" width="70" height="80" onclick="editPeople(${item.id})" class="img-rounded center-block">
                </div>
                <div class="text-center">
                    ${item.name}
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

          <hr>

          <%-- 以下是删除的人员 --%>
          <ul class="nav nav-tabs">
            <c:forEach items="${deletePeoples}" var="item" varStatus="status">
              <li style="width: 25%;height: 120px;">
                <div class="text-center">
                  <div>
                    <ul class="nav nav-tabs">
                      <li style="width: 50%;height: 1px;float: left">

                      </li>
                      <li style="width: 50%;height: 1px;float: right">
                        <img src="/resources/static/image/recover.png" width="20" height="20" onclick="changeStatus(${item.id},'${item.name}','recover')">
                      </li>
                    </ul>
                  </div>
                  <img src="${item.headBase64}" width="70" height="80" onclick="editPeople(${item.id})" class="img-rounded center-block">
                </div>
                <div class="text-center">
                    ${item.name}
                </div>
              </li>
            </c:forEach>
          </ul>
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
                  <input type="hidden" id="parishId" name="parishId" value="${parish.id}"/>
                  <input type="hidden" id="pid" name="id" value=""/>
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
                  <div class="form-group" style="display: none" id="div_head">
                    <label for="headUpload" class="col-sm-2 control-label">头像</label>
                    <div class="col-sm-10">
                      <input id="headUpload" type="file" accept="image/*" style="width: 200px"/>
                      <img src="" width="140" height="160"/>
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
    </div>
  </div>
</body>

<script type="text/javascript">
    var _contextPath = "<%=request.getContextPath()%>";

    function addPeople(){
        $("#myModalLabel").html("添加人员");
        $("#div_head").hide();
        $("#pid").val("");
        $("#modal-container-addPeople").modal('show');
        return false;
    }

    function changeStatus(id, name, flag){
        var desc = "删除";
        var status = -1;
        if(flag == "recover"){
            desc = "恢复";
            status = 1;
        }

        if(confirm("[ "+name+" ] 确定"+desc+"？")){
            $.ajax({
                url: _contextPath+"/churchPeople/changeStatus",
                type: "POST",
                data: {"id":id, "status":status},
                dataType: "json",
                success: function (returnData) {
                    var resultObj = eval(returnData);
                    if (resultObj.code == "true") {
                        location.reload(true);
                    }else{
                        alert(resultObj.message);
                    }
                }
            });
        }
        return false;
    }

    function savePeople(){
        var formValues = $("#savePeopleForm").serialize();
        //console.log(formValues);
        if(confirm("确认保存吗？")){
            $.ajax({
                url: _contextPath+"/churchPeople/addOrUpdate",
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

    function editPeople(id) {
        if(!id){
            alert("人员id有误");
            return false;
        }
        $.ajax({
            url: _contextPath+"/churchPeople/findById",
            type: "GET",
            data: {"id":id},
            dataType: "json",
            success: function (returnData) {
                var resultObj = eval(returnData);
                if (resultObj.code == "true") {
                    var people = returnData.result;
                    //console.log(people);
                    $("#myModalLabel").html("修改人员");
                    $("#div_head").show();
                    $("#pid").val(id);
                    $("#name").val(typeof(people.name)==="undefined"?"":people.name);
                    $("#mobile").val(typeof(people.mobile)==="undefined"?"":people.mobile);
                    $("#gender").val(typeof(people.gender)==="undefined"?"":people.gender);
                    $("#ageGroup").val(typeof(people.ageGroup)==="undefined"?"":people.ageGroup);
                    $("#birthday").val(typeof(people.birthdayStr)==="undefined"?"":people.birthdayStr);
                    $("#sort").val(typeof(people.sort)==="undefined"?"":people.sort);
                    $("#remark").val(typeof(people.remark)==="undefined"?"":people.remark);
                    $("#headUpload").parent().find("img").attr("src",typeof(people.headBase64)==="undefined"?"":people.headBase64);

                    $('#modal-container-addPeople').modal('show');

                }else{
                    alert(resultObj.message);
                }
            }
        });
    }

    /**
     * 图片上传
     */
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
                var pid = $("#pid").val();
                if(!pid || parseInt(pid)<1){
                    alert("请先保存信息");
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
                rst.formData.append('id', pid);
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


</script>
</html>


