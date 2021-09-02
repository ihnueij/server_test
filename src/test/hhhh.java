package test;

import java.sql.*;
import java.util.Scanner;

public class hhhh {
    public static void main(String[] args) {

        String url = "jdbc:postgresql://localhost:5432/postgres";
        String user = "postgres";
        String password = "1234";

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(url, user, password);
            System.out.println("연결성공");


            String sql = "select name from test";
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();//select만

            System.out.println("이름");
            System.out.println("==================================");

            while(rs.next()){
                String name = rs.getString("name");
                System.out.println(name);
                System.out.println();
            }
        }catch (SQLException e){
            System.out.println("db연결 실패 드라이버 연결 정보 오류");
            e.printStackTrace();
        }catch (ClassNotFoundException e){
            System.out.println("db연결 실패 클래스 파일 오류");
            e.printStackTrace();
        }catch (Exception e){
            System.out.println("실패!");
            e.printStackTrace();
        }try{
            if (rs != null)rs.close();
            if (pstmt != null)pstmt.close();
            if (con != null)con.close();

        }catch (SQLException e){
        }

    }
}
