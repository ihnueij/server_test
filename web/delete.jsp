<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="example.DBConnection" %><%--
  Created by IntelliJ IDEA.
  User: sjinc
  Date: 2021-08-25
  Time: 오전 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>DELETE</title>
</head>
<body>
<%
    int no = Integer.parseInt(request.getParameter("no"));

    Connection con = null;
    PreparedStatement pstmt = null;
    String sql = "delete from users where no =?";


    try {
        con = DBConnection.getConnection();
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, no);
        int re = pstmt.executeUpdate();
        if (re == 1) {
%>
    <script>
        alert("delete 완료 !");
        location.href = 'select.jsp';
    </script>
<%
} else
%>
    <script>
        alert("delete 실패..");
        location.href = 'select.jsp';
    </script>
<%

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

%>
</body>
</html>
