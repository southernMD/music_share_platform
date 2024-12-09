package comY.dao.view;

import comY.Config;
import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class musicDao {
    public static ResultSet getMusic(int nowPage) throws SQLException {
        try{
            Connection connection = connectMysql.getConnection();
            String sql = """
                    SELECT * FROM songs
                    ORDER BY public_time
                    DESC
                    LIMIT ?,5""";
            PreparedStatement ptmt =  connection.prepareStatement(sql);
            ptmt.setInt(1,(nowPage-1)*Integer.parseInt(Config.PageSize.getValue()));
            return  ptmt.executeQuery();
        }catch (SQLException e){
            throw new SQLException(e);
        }
    }
    public static ResultSet getMusicCount() throws SQLException {
        try {
            Connection conn = connectMysql.getConnection();
            String sql = "SELECT count(*) as totalItems,ceil(count(*)/?) as totalPage from songs";
            PreparedStatement ptmt =  conn.prepareStatement(sql);
            ptmt.setInt(1, Integer.parseInt(Config.PageSize.getValue()));
            return ptmt.executeQuery();
        } catch (SQLException e) {
            throw new SQLException(e);
        }
    }
}
