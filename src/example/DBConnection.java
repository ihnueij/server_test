package example;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() throws SQLException, NamingException,
            ClassNotFoundException {

        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/post"); //반드시 DB 이름은 web.xml의 <res-ref-name>과 같아야 한다.
        Connection con = ds.getConnection();

        return con;

    }

}
