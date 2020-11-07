<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ include file="taglib.jsp" %>
<script src="${ctxStatic}/js/jquery.min.js" type="text/javascript"></script>
<html>
<head>
    <title>Ajax Test</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(function () {
            var room = {
                id: "1245"
            };
            var college = {
                id: "1234",
                room: room
            };

            $("#btnSubmit1").click(function () {
                var param = JSON.stringify(college);
                $.ajax({
                    url: "${ctx}/ajaxTest/contentTypeJson",
                    type: "post",
                    data: param,
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        console.log(data);
                    }
                });
            });
            $("#btnSubmit2").click(function () {
                $.ajax({
                    url: "${ctx}/ajaxTest/contentTypeText",
                    type: "post",
                    data: "id=123&room.id=1234",
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                    }
                });
            });
            $("#btnSubmit3").click(function () {   //成功 但 不能传递任何数据
                var param = JSON.stringify(college);
                $.ajax({
                    url: "${ctx}/ajaxTest/contentTypeText",
                    type: "post",
                    data: param,
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        console.log(data);
                    }
                });
            });
            $("#btnSubmit4").click(function () {

                //var  param =JSON.stringify(college); 不行
                $.ajax({
                    url: "${ctx}/ajaxTest/contentTypeJson",
                    type: "post",
                    //data: "id=123&room.id=1234", 这样传递参数会报400
                    //data:param,这样传递参数会报400
                    data: college,  //不行
                    dataType: "json",
                    // contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        console.log(data);
                    }
                });
            });
        });

        /**
         ajax提交文件导入
         */
        function doUpload() {
            var formData = new FormData($("#uploadForm")[0]);
            debugger;
            $.ajax({
                url: "${ctx}/ajaxTest/upload",
                type: 'POST',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    console.log(data);
                },
                error: function (data) {
                    debugger;
                    console.log(data);
                }
            });
        }
    </script>
</head>
<body>

<div class="form-actions">
    <p>------------------contentType测试-----------------------</p>
    JSON类型请求并将参数通过 JSON.stringify(hotel)转换了&nbsp;<br/>
    接口内部使用 RequestBody注解 &nbsp; <br/>
    <input id="btnSubmit1" class="btn" type="button" value="contentTypeJson1"/>&nbsp;<br/>
    JSON类型请求,但ContentType 默认,参数通过key=value&拼接&nbsp;<br/>
    接口内部没有&nbsp;<br/>
    使用 RequestBody注解 &nbsp;<br/>
    <input id="btnSubmit2" class="btn" type="button" value="contentTypeText1"/>&nbsp;<br/>

    JSON类型请求并将参数通过 JSON.stringify(hotel)转换了&nbsp;<br/>
    接口内部没有使用RequestBody注解 &nbsp; <br/>

    失败,后端接口没有接收到请求参数，也没有返回请求参数 &nbsp; <br/>
    <input id="btnSubmit3" class="btn" type="button" value="contentTypeText2"/>&nbsp;<br/>
    JSON类型请求,但ContentType 默认,参数通过key=value&拼接&nbsp;<br/>
    接口内部使用 RequestBody注解 &nbsp;<br/>
    失败,后端接口没有接收到请求参数，也没有返回请求参数
    且后端抛出一个警告异常,前端400 &nbsp; <br/>
    <input id="btnSubmit4" class="btn" type="button" value="contentTypeJson2"/><br/>
    <p>-----------------------文件上传测试----------------------</p>
    <form id="uploadForm">
        <p>指定文件名： <input type="text" name="filename" value=""/></p>
        <p>上传文件： <input type="file" name="file"/></p>
        <input type="button" value="上传" onclick="doUpload()"/>
    </form>
</div>
</body>
</html>