package comY.dao;

import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import comY.util.getTime;
public class sendCommentDao {
    static public Integer sendComment(int discuss_id,int user_Id,String textarea) throws SQLException {
        Connection connection = connectMysql.getConnection();
        String sql = "INSERT INTO comment (comment_time,discuss_id, message, user_id) VALUES (?,?,?,?)";
        try {
            PreparedStatement ptmt = connection.prepareStatement(sql);
            ptmt.setTimestamp(1,getTime.getNowTime());
            ptmt.setInt(2,discuss_id);
            ptmt.setString(3,textarea);
            ptmt.setInt(4,user_Id);
            return ptmt.executeUpdate();
        }catch (SQLException e){
            throw new SQLException(e);
        }
    }
}
