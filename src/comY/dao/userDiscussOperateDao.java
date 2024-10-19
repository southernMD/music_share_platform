package comY.dao;

import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class userDiscussOperateDao {
    private static final Connection conn = connectMysql.getConnection();
    public static int like(Integer user_id, Integer discuss_id) throws SQLException {
        String sql = "INSERT INTO discuss_like  (discuss_id,user_id)\n" +
                "values (?,?)";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1, discuss_id);
        ptmt.setInt(2, user_id);
        int t =  ptmt.executeUpdate();
        return t;
    }
    public static int dislike(Integer user_id, Integer discuss_id) throws SQLException {
        String sql = "INSERT INTO discuss_dislike  (discuss_id,user_id)\n" +
                "values (?,?)";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1, discuss_id);
        ptmt.setInt(2, user_id);
        int t =  ptmt.executeUpdate();
        return t;
    }
    public static int del_like(Integer user_id, Integer discuss_id) throws SQLException {
        String sql = "DELETE FROM discuss_like WHERE user_id = ? AND discuss_id = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1, user_id);
        ptmt.setInt(2, discuss_id);
        return ptmt.executeUpdate();
    }
    public static int del_dislike(Integer user_id, Integer discuss_id) throws SQLException {
        String sql = "DELETE FROM discuss_dislike WHERE user_id = ? AND discuss_id = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setInt(1, user_id);
        ptmt.setInt(2, discuss_id);
        return ptmt.executeUpdate();
    }
}
