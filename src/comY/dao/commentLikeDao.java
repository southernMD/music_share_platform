package comY.dao;

import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class commentLikeDao {
    private static String like = "INSERT INTO " +
            "comment_like(user_id,comment_id) VALUES(?,?)";
    private static String unLike = "DELETE FROM comment_like " +
            "WHERE user_id=? AND comment_id=?";
    static public int like(int comment_id,int user_id) throws Exception{
        Connection connection = connectMysql.getConnection();
        PreparedStatement ptmt = connection.prepareStatement(like);
        ptmt.setInt(1,user_id);
        ptmt.setInt(2,comment_id);
        return ptmt.executeUpdate();
    }
    static public Integer unLike(int comment_id,int user_id) throws  Exception{
        Connection connection = connectMysql.getConnection();
        PreparedStatement ptmt = connection.prepareStatement(unLike);
        ptmt.setInt(1,user_id );
        ptmt.setInt(2,comment_id);
        return ptmt.executeUpdate();
    }
}
