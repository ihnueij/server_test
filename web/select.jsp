<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="example.DBConnection" %>
<%@ page import="java.sql.DriverManager" %>
<%--
  Created by IntelliJ IDEA.
  User: sjinc
  Date: 2021-08-24
  Time: 오전 8:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    //    String uid = "edu";
//    String pwd = "edu";
//    String url = "jdbc:postgresql://localhost:5432/edu";
    String sql = "select * from users";%>
<html>
<head>
    <title>SELECT</title>
</head>
<body>
<p>SELECT DB USERS TABLE</p>
<%
    request.setCharacterEncoding("UTF-8");
    try {
        //        Class.forName("org.postgresql.Driver");
        //        Connection con = DriverManager.getConnection(url, user, password);
        con = DBConnection.getConnection();
        pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();
%>
<table border="3" bordercolor="skyblue">
    <tr bgcolor="skyblue">
        <td>no</td>
        <td>name</td>
        <td>phone</td>
        <td>address</td>
    </tr>

    <%
        // 결과값을 출력한다.
        while (rs.next()) {
            int no = rs.getInt("no");
            String name = rs.getString("name");
            String phone = rs.getString("phone");
            String address = rs.getString("address");

    %>
    <tr>
        <td><%= no %></td>
        <td><%=name%></td>
        <td><%=phone%></td>
        <td><%=address%></td>
        <td><a href="update.jsp?no=<%=no%>">수정</a></td>
        <td><a href="delete.jsp?no=<%=no%>">삭제</a></td>
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
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
    <tr>
        <td colspan="6">
            <input type="button" value="INSERT" onclick="javascript:window.location='insert.jsp'">
        </td>
    </tr>
</table>
</body>
</html>
