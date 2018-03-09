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
  <title>敬拜日期</title>
  <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1,user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="format-detection" content="telephone=no" />
  <meta name="format-detection" content="email=no" />

  <link rel="stylesheet" type="text/css" href="/resources/static/jquery-pagination/css/pagination.css"/>
  <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap.css"/>
  <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap-theme.css"/>
  <script type="text/javascript" src="/resources/static/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="/resources/static/jquery-pagination/js/jquery.pagination.js"></script>
  <script type="text/javascript" src="/resources/static/bootstrap-3.3.7/js/bootstrap.js"></script>
  <script type="text/javascript" src="/resources/static/My97DatePicker/WdatePicker.js"></script>
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

        <div>
          <a href="javascript:;" onclick="toAddLesson()">添加</a>
        </div>

        <div class="tab-pane" id="panel-date" style="margin-top: 10px">
          <form id="searchForm" method="post" action="/churchParishLesson/list">
            <input id="pageNo" name="pageNo" value="${lessonQuery.pageNo}" type="hidden"/>
            <input id="parishId" name="parishId" value="${lessonQuery.parishId}" type="hidden"/>
          </form>

          <table class="table table-hover">
            <thead>
            <tr>
              <th>敬拜日期</th>
              <th>讲员</th>
              <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${parishLessons}" var="item" varStatus="status" >
              <c:choose>
                <c:when test="${status.index % 2 ==0 }"><c:set var="trClass" scope="page" value="info"/></c:when>
                <c:when test="${status.index % 2 ==1 }"><c:set var="trClass" scope="page" value="success"/></c:when>
              </c:choose>
              <tr class="${trClass}">
                <td>
                  <fmt:formatDate value="${item.worshipDate}" pattern="yyyy-MM-dd"></fmt:formatDate>
                </td>
                <td>
                    ${item.teacher}
                </td>
                <td>
                  <a href="javascript:;" onclick="editLesson(${item.id},'${item.worshipDateStr}','${item.teacher}')">修改</a>
                  |
                  <a href="/prLessonPeople/toSignView?lessonId=${item.id}">签到情况</a>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
          <div id="listPage" class="pagination"></div>
        </div>

        <%-- 添加日期遮罩层 start--%>
        <div id="modal-container-addLesson" role="dialog" class="modal fade" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">
                  添加日期
                </h4>
              </div>
              <div class="modal-body">
                <form role="form" id="saveLessonForm">
                  <input type="hidden" name="parishId" value="${parish.id}"/>
                  <input type="hidden" id="lid" name="id" value=""/>
                  <div class="form-group">
                    <label for="worshipDate" class="col-sm-2 control-label">敬拜日期</label>
                    <div class="col-sm-10">
                      <input id="worshipDate" name="worshipDate" class="form-control" type="text" readonly onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="" placeholder="请输入敬拜日期"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="teacher" class="col-sm-2 control-label">讲员</label>
                    <div class="col-sm-10">
                      <input id="teacher" name="teacher" class="form-control" type="text" placeholder="请输入讲员"/>
                    </div>
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveLesson()">保存</button>
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

    $("#listPage").pagination('${total}', {
        next_text : ">",
        prev_text : "<",
        link_to : "javascript:void(0)",
        current_page : '${lessonQuery.pageNo-1}',
        num_display_entries : 3,
        items_per_page : '${lessonQuery.pageSize}',
        num_edge_entries : 1,
        callback:function(page,jq){
            var pageNo = page + 1;
            querylist(pageNo);
        }
    });

    /**
     * 查询列表
     */
    function querylist(pageNo) {
        if (checkQueryForm()) {
            $('#pageNo').val(pageNo);
            $("#searchForm")[0].submit();
        }
    }

    function checkQueryForm() {
        return true;
    }

    function toAddLesson() {
        $("#myModalLabel").html("添加日期");
        $("#lid").val("");
        $("#modal-container-addLesson").modal('show');
        return false;
    }

    function editLesson(id, dateStr, teacher) {
        if(!id){
            alert("id有误");
            return false;
        }

        $("#myModalLabel").html("修改日期");
        $("#lid").val(id);
        $("#worshipDate").val(dateStr);
        $("#teacher").val(teacher);
        $('#modal-container-addLesson').modal('show');
    }

    function saveLesson() {
        var formValues = $("#saveLessonForm").serialize();
        if(confirm("确认保存吗？")){
            $.ajax({
                url: _contextPath+"/churchParishLesson/addOrUpdate",
                type: "POST",
                data: formValues,
                dataType: "json",
                success: function (returnData) {
                    var resultObj = eval(returnData);
                    if (resultObj.code == "true") {
                        $('#modal-container-addLesson').modal('hide');
                        location.reload(true);
                    }else{
                        alert(resultObj.message);
                    }
                }
            });
        }
        return false;
    }

</script>
</html>


