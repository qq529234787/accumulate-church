<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>签到</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1,user-scalable=no">
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="format-detection" content="telephone=no" />
  <meta name="format-detection" content="email=no" />

  <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap.css"/>
  <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap-theme.css"/>
  <script type="text/javascript" src="/resources/static/js/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="/resources/static/bootstrap-3.3.7/js/bootstrap.js"></script>

  <script>
      function goHref(parishId) {
          if(!parishId){
              alert("堂点id错误");
              return false;
          }
          window.location.href = "/churchParishLesson/parishIndex?parishId="+parishId;
      }
  </script>
</head>

<body>
<div class="container">
  <div class="row clearfix">
    <div class="col-md-12 column">
      <br>
      <c:forEach items="${churchParishs}" var="item" varStatus="status" >
        <div class="panel panel-primary">
          <div class="panel-heading">
            <h3 class="panel-title">
                ${item.name}
            </h3>
          </div>
          <div class="panel-body">
              <ul class="nav nav-tabs">
                  <li style="width: 50%;">
                      <div style="text-align:center;">
                          <a href="/churchPeople/list?parishId=${item.id}">人员</a>
                      </div>
                  </li>
                  <li style="width: 50%;">
                      <div style="text-align:center;">
                          <a href="/churchParishLesson/list?parishId=${item.id}">敬拜日期</a>
                      </div>
                  </li>
              </ul>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>
</body>
</html>