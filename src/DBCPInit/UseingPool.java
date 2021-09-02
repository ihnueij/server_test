package DBCPInit;

import org.apache.tomcat.dbcp.dbcp2.ConnectionFactory;

import java.sql.*;

public class UseingPool {
    public static void main(String[] args) {
        Connection con = null;
        PreparedStatement pstmt =null;
        ResultSet rs = null;

        try {
            String jdbcDriver = "jdbc:apache:commons:dbcp:/server_test";
//            Class.forName("org.apache.commons.dbcp2.PoolingDriver");
//            Class.forName("org.postgresql.Driver");

            String sql = "select * from users";
            con = DriverManager.getConnection(jdbcDriver);//jdbcDriver
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String no = rs.getString("no");
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                System.out.printf("%s\t\t%s\t\t%s\t%s\t",no,name,phone,address);
                System.out.println();
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if(rs != null)try{rs.close();}catch (SQLException ex){}
            if(pstmt != null)try{pstmt.close();}catch (SQLException ex){}
            if(con != null)try{con.close();}catch (SQLException ex){}
        }

    }
}
