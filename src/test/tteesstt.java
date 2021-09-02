package test;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class tteesstt {
    public static void main(String[] args) {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/test"); //반드시 DB 이름은 web.xml의 <res-ref-name>과 같아야 한다.
            Connection con = ds.getConnection();

            StringBuilder sql = new StringBuilder();
            sql.append("select * from test");
            PreparedStatement pstmt = con.prepareStatement(sql.toString());
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                System.out.println(rs.getString("no"));
                System.out.println(rs.getString("name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
