package comY.util;

import java.sql.*;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
//导入Config枚举
import comY.Config;
import comY.myInterface.ResultSetExtractor;

public class connectMysql {

    // 单例模式的私有构造方法
    private static class SingletonHolder {
        private static final Connection INSTANCE;
        static {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                INSTANCE = DriverManager.getConnection(Config.HOST_URL.getValue(), Config.USER.getValue(), Config.PASSWORD.getValue());
            } catch (ClassNotFoundException | SQLException e) {
                throw new RuntimeException("无法初始化数据库连接", e);
            }
        }
    }

    // 获取数据库连接的静态方法
    public static Connection getConnection() {
        return SingletonHolder.INSTANCE;
    }

    public static <T> List<T> queryToArrayList(ResultSet rs, ResultSetExtractor<T> extractor) {
        List<T> resultList = new ArrayList<>();
        try {
            while (rs.next()) {
                T result = extractor.extract(rs);
                resultList.add(result);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;

    }


}
