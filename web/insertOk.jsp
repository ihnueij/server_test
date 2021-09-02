<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="example.DBConnection" %>
<%@ page import="example.HanConv" %><%--
  Created by IntelliJ IDEA.
  User: sjinc
  Date: 2021-08-25
  Time: 오전 9:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //    int no = Integer.parseInt("no");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    Connection con = null;
    PreparedStatement pstmt = null;

    String sql = "insert into users values (nextval('user_seq'),?,?,?);";%>
<html>
<head>
    <title>INSERT</title>
</head>
<body>
<p>INSERT DB USER TABLE</p>
<%
    try {
        con = DBConnection.getConnection();
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, HanConv.toKor(name));
        pstmt.setString(2, phone);
        pstmt.setString(3, HanConv.toKor(address));
        int re = pstmt.executeUpdate();
        if (re == 1) {
%>
    <script>
        alert("insert 완료 !");
        location.href = 'select.jsp';
    </script>
<%
} else
%>
    <script>
        alert("insert 실패..");
        location.href = 'insert.jsp';
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
