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
  <title>堂点</title>
  <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0" />
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

  <script>

  </script>
</head>

<body>
    <form id="searchForm" method="post" action="/churchParish/list">
        <input id="pageNo" name="pageNo" value="${churchParishQuery.pageNo}" type="hidden"/>
    </form>
  <table cellspacing="1" border="1">
    <thead>
      <tr style="height: 30px;">
        <td style="width: 50px;text-align: center">id</td>
        <td style="width: 100px;text-align: center">名称</td>
        <td style="width: 100px;text-align: center">地点</td>
        <td style="width: 200px;text-align: center">备注</td>
        <td style="width: 200px;text-align: center">操作</td>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${churchParishs}" var="item" varStatus="status" >
        <tr style="height: 30px;">
          <td>${item.id}</td>
          <td>${item.name}</td>
          <td>${item.address}</td>
          <td>${item.remark}</td>
          <td>
              <a href="/churchPeople/list?parishId=${item.id}">名单</a>
              |
              <a href="/churchParishLesson/list?parishId=${item.id}">敬拜日期</a>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <div id="listPage" class="pagination"></div>
</body>

<script type="text/javascript">
    $("#listPage").pagination('${total}', {
        next_text : "下一页",
        prev_text : "上一页",
        link_to : "javascript:void(0)",
        current_page : '${churchParishQuery.pageNo-1}',
        num_display_entries : 8,
        items_per_page : '${churchParishQuery.pageSize}',
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

    function addObj(){
        window.location.href = "/churchParishLesson/toAdd";
    }

    function changeStatus(id, status) {
        if (!id) {
            alert("id不正确");
            return false;
        }
        if (confirm("确定删除id:" + id)) {
            $.ajax({
                type: "POST",
                url: "/churchParishLesson/changeStatus",
                data: {"id":id, "status":status},
                dataType: "json",
                async: false,
                success: function (data) {
                    var resultObj = eval(data);
                    if (resultObj.code == "true") {
                        alert("操作成功");
                        $("#searchForm")[0].submit();
                    } else {
                        alert("操作失败. " + resultObj.message);
                    }
                }
            });
        }
    }



</script>
</html>


