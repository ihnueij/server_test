package DBCPInit;

import org.apache.tomcat.dbcp.dbcp2.*;
import org.apache.tomcat.dbcp.pool2.impl.GenericObjectPool;
import org.apache.tomcat.dbcp.pool2.impl.GenericObjectPoolConfig;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import java.sql.DriverManager;

public class DbcpInit extends HttpServlet {

    @Override
    public void init() throws ServletException {
        loadJDBCDriver();//driver 로딩
        initConnectionPool();//connectionPool 생성
    }

    private void loadJDBCDriver() {
        try {
            String driver = getServletConfig().getInitParameter("jdbcDriver");
            Class.forName(driver);//connection pool 내부에서 사용할 jdbc 드라이버 로딩
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("fail to load JDBC Driver", e);
        }
    }
    private void initConnectionPool(){
        try {
            String jdbcUrl = getServletConfig().getInitParameter("jdbcUrl");
            String username = getServletConfig().getInitParameter("userName");
            String pw = getServletConfig().getInitParameter("pw");

            //ConnectionFactory: pool이 connection을 생성할 떄 사용하는
            ConnectionFactory connFactory = new DriverManagerConnectionFactory(jdbcUrl, username, pw);
            //PoolableConnectionFactory: PoolableConnection을 생성하는 팩토리(DBCP가 pool에 connection을 보관 할 때 사용하는 )
            PoolableConnectionFactory poolableConnFactory = new PoolableConnectionFactory(connFactory, null);
            //커넥션이 유효한지 여부를 검사할 때 사용할 쿼리
            poolableConnFactory.setValidationQuery("select 1");

            //connection pool 설정 정보들
            GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();
            poolConfig.setTimeBetweenEvictionRunsMillis(1000L * 60L * 5L);//유휴 커넥션 검사 주기
            poolConfig.setTestWhileIdle(true);//풀에 보관 중인 커넥션이 유효한지 감사할지 여부
            poolConfig.setMinIdle(4);//커넥션 최소 개수
            poolConfig.setMaxTotal(50);//커넥션 최대 개수

            //connection pool 생성: 커넥션을 보관할 곳을 생성하는 팩토리와 설정정보를 파라미터로 받는다
            GenericObjectPool<PoolableConnection> connectionPool = new GenericObjectPool<>(poolableConnFactory, poolConfig);
            poolableConnFactory.setPool(connectionPool);//팩토리에 커넥션 풀 연결

            //커넥션 풀을 제공하는 jdbc 드라이버 등록
            Class.forName("org.apache.commons.dbcp2.PoolingDriver");
            PoolingDriver driver = (PoolingDriver) DriverManager.getDriver("jdbc:apache:commons:dbcp:");

            //커텍션 풀 드라이버에 connection pool 등록 및 이름 설정
            driver.registerPool("server_test", connectionPool);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
