<%--
  Created by IntelliJ IDEA.
  User: sjinc
  Date: 2021-08-25
  Time: 오전 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="insertOk.jsp">
    <table>
        <tr>
            <td>이름:<input type="text" name="name"></td>
            <td>번호:<input type="text" name="phone"></td>
            <td>주소:<input type="text" name="address"></td>
        </tr>
        <tr>
            <td><input type="submit" value="insert"></td>
        </tr>
    </table>
</form>
</body>
</html>
