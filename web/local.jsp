<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="example.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    //    String uid = "postgres";
   //    String pwd = "1234";
  //    String url = "jdbc:postgresql://localhost:5432/postgres";
    String sql = "select * from users";
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<p>아래는 DB 내용</p>

<%
    try {

//        Class.forName("org.postgresql.Driver");
//        conn = DriverManager.getConnection(url, uid, pwd);
        conn = DBConnection.getConnection();
        // 쿼리를 생성gkf 객체 생성
        pstmt = conn.prepareStatement(sql);
        // 쿼리 생성
        rs = pstmt.executeQuery();

%>
<table border="1">
    <tr>
        <td>id</td>
        <td>name</td>
        <td>pw</td>
        <td>폰번호</td>
        <td>이메일</td>
    </tr>
    <%
        while (rs.next()) {
    %>
    <tr>
        <td><%=rs.getString("id")%>
        </td>
        <td><%=rs.getString("name")%>
        </td>
        <td><%=rs.getString("pw")%>
        </td>
        <td><%=rs.getString("phone")%>
        </td>
        <td><%=rs.getString("email")%>
        </td>
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
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</table>

</body>
</html>
