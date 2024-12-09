package comY.dao.view;

import comY.entity.Song;
import comY.entity.User;
import comY.myInterface.ResultSetExtractor;
import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class musicDetailDao {
    public static ResultSet getMusicDetail(Integer id) throws SQLException {
        try {
            Connection conn = connectMysql.getConnection();
            String sql = "SELECT * from songs where id = ?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,id);
            return ptmt.executeQuery();
        }catch (SQLException e){
            throw new SQLException(e);
        }
    }

    public static ResultSet getMusicPublicDetail(Integer id) throws SQLException {
        try {
            Connection conn = connectMysql.getConnection();
            String sql = "SELECT id,user_name,avatar,des from user where id = ?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,id);
            return ptmt.executeQuery();
        }catch (SQLException e){
            throw new SQLException(e);
        }
    }
}
