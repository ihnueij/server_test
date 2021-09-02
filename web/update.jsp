<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="example.DBConnection" %><%--
  Created by IntelliJ IDEA.
  User: sjinc
  Date: 2021-08-25
  Time: 오전 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>UPDATE</title>
</head>
<body>
<%
    int no = Integer.parseInt(request.getParameter("no"));

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "select * from users where no=?";

    try {
        con = DBConnection.getConnection();
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, no);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String name = rs.getString("name");
            String phone = rs.getString("phone");
            String address = rs.getString("address");


%>
<form name="frm1" action="updateOk.jsp" method="post">
    <table>
        <tr>
            <td>no</td>
            <td><%=no%><input type="hidden" name="no" value="<%=no%>"></td>
        </tr>
        <tr>
            <td>name</td>
            <td><input type="text" name="name" value="<%=name%>"></td>
        </tr>
        <tr>
            <td>phone</td>
            <td><input type="text" name="phone" value="<%=phone%>"></td>
        </tr>
        <tr>
            <td>address</td>
            <td><input type="text" name="address" value="<%=address%>"></td>
        </tr>
        <tr>
            <td>
                <input type="button" name="btn1" value="update" onclick="javascript:frm1.submit();">
                <input type="button" name="btn2" value="select" onclick="javascript:location.href='select.jsp';">
            </td>
        </tr>
    </table>
</form>
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
    <script type="text/javascript">
        function update() {
            document.frm1.submit();
        }

        function select() {
            location.href = "select.jsp";
        }
    </script>
</body>
</html>
