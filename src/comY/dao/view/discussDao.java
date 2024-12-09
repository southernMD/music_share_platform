package comY.dao.view;

import comY.Config;
import comY.entity.Discuss;
import comY.myInterface.ResultSetExtractor;
import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class discussDao {
    public static ResultSet getDiscuss() throws SQLException
    {
        try {
            Connection conn = connectMysql.getConnection();
            String sql = "SELECT count(*) as totalItems,ceil(count(*)/?) as currentPage from discuss";
            PreparedStatement ptmt =  conn.prepareStatement(sql);
            ptmt.setInt(1, Integer.parseInt(Config.PageSize.getValue()));
            return ptmt.executeQuery();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
