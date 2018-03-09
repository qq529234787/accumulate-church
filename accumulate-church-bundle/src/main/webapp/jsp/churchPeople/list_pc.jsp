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
    <title>名单</title>

    <%--<meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />--%>

    <link rel="stylesheet" type="text/css" href="/resources/static/jquery-pagination/css/pagination.css"/>
    <%--<link rel="stylesheet" type="text/css" href="/resources/static/tether-1.3.3/css/tether.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/static/tether-1.3.3/css/tether-theme-basic.css"/>--%>
    <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/static/bootstrap-3.3.7/css/bootstrap-theme.css"/>

    <script type="text/javascript" src="/resources/static/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/resources/static/jquery-pagination/js/jquery.pagination.js"></script>
    <%--<script type="text/javascript" src="/resources/static/tether-1.3.3/js/tether.min.js"></script>--%>
    <script type="text/javascript" src="/resources/static/bootstrap-3.3.7/js/bootstrap.js"></script>
    <script type="text/javascript" src="/resources/static/js/lrz/lrz.bundle.js"></script>
</head>

<body>
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <form role="form" class="form-horizontal" id="searchForm" method="post" action="/churchPeople/list">
                <input id="pageNo" name="pageNo" value="${churchPeopleQuery.pageNo}" type="hidden"/>
                <input id="parishId" name="parishId" value="${churchPeopleQuery.parishId}" type="hidden"/>
                <div class="form-group">
                    <label for="name" class="col-sm-2 control-label">姓名</label>
                    <div class="col-sm-10">
                        <input id="name" name="name" type="text" class="form-control" value="${churchPeopleQuery.name}" placeholder="请输入名字" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="status" class="col-sm-2 control-label">状态</label>
                    <div class="col-sm-10">
                        <select id="status" name="status" class=" custom-select">
                            <option value="1" <c:if test="${churchPeopleQuery.status == 1}">selected</c:if>>正常</option>
                            <option value="0" <c:if test="${churchPeopleQuery.status == 0}">selected</c:if>>无效</option>
                            <option value="-1" <c:if test="${churchPeopleQuery.status == -1}">selected</c:if>>删除</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <input type="submit" class="btn btn-default" onclick="querylist(1);" value="查询"/>
                        <input type="button" class="btn btn-default" onclick="addObj(${churchPeopleQuery.parishId});" value="新增"/>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-hover">
                <%--<caption>基本的表格布局</caption>--%>
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>手机</th>
                        <th>生日</th>
                        <th>排序</th>
                        <th>头像</th>
                        <th>所属堂</th>
                        <th>备注</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${churchPeoples}" var="item" varStatus="status">
                        <c:choose>
                            <c:when test="${status.index % 5 ==0 }"><c:set var="trClass" scope="page" value="success"/></c:when>
                            <c:when test="${status.index % 5 ==1 }"><c:set var="trClass" scope="page" value="danger"/></c:when>
                            <c:when test="${status.index % 5 ==2 }"><c:set var="trClass" scope="page" value=""/></c:when>
                            <c:when test="${status.index % 5 ==3 }"><c:set var="trClass" scope="page" value="info"/></c:when>
                            <c:when test="${status.index % 5 ==4 }"><c:set var="trClass" scope="page" value="warning"/></c:when>
                        </c:choose>
                        <tr class="${trClass}">
                            <td>${churchPeopleQuery.startRow+status.index+1}</td>
                            <td>${item.name}</td>
                            <td>
                                <c:forEach items="${GenderEnumArr}" var="gender" varStatus="sta">
                                    <c:if test="${item.gender == gender.status}">
                                        ${gender.value}
                                    </c:if>
                                </c:forEach>

                            </td>
                            <td>${item.mobile}</td>
                            <td><fmt:formatDate value="${item.birthday}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            <td>${item.sort}</td>
                            <td>
                                <img src="${item.headBase64}" pid="${item.id}" width="70" height="80"/>
                            </td>
                            <td>${item.parishId}</td>
                            <td>${item.remark}</td>
                            <td>
                                <a href="/churchPeople/toEdit?id=${item.id}">修改</a>
                                |
                                <a href="javascript:;">
                                    <input type="file" accept="image/*" class="headUpload" pid="${item.id}" style="width: 80px" value="更改头像">
                                </a>
                                |
                                <c:choose>
                                    <c:when test="${churchPeopleQuery.status == 1}">
                                        <a href="#" onclick="changeStatus(${item.id}, 0)">设为无效</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="#" onclick="changeStatus(${item.id}, 1)">恢复</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div id="listPage" class="pagination"></div>
    </div>
</div>

</body>

<script type="text/javascript">
    var _contextPath = "<%=request.getContextPath()%>";

    $("#listPage").pagination('${total}', {
        next_text : "下一页",
        prev_text : "上一页",
        link_to : "javascript:void(0)",
        current_page : '${churchPeopleQuery.pageNo-1}',
        num_display_entries : 8,
        items_per_page : '${churchPeopleQuery.pageSize}',
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

    function addObj(parishId){
        if(!parishId){
            parishId = 1;
        }
        window.location.href = "/churchPeople/toAdd?parishId="+parishId;
    }

    function changeStatus(id, status) {
        if (!id) {
            alert("id不正确");
            return false;
        }
        if (confirm("确定删除id:" + id)) {
            $.ajax({
                type: "POST",
                url: "/churchPeople/changeStatus",
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

    /**
     * 上传头像
     */
    $(".headUpload").on("change", function () {
        var inputFile = this;
        var id = $(this).attr("pid");
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
                            $("img[pid='"+id+"']").attr("src", rst.base64);

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
</script>
</html>


