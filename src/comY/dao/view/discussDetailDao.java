package comY.dao.view;

import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class discussDetailDao {
    public static ResultSet getShowDiscusses(int user_id,int id) throws SQLException {
        try{
            Connection conn = connectMysql.getConnection();
            String sql = """
                SELECT
                    discuss.*,
                    u.avatar AS publicer_avatar,
                    u.user_name AS publicer_name,
                    COALESCE(dl.like_count, 0) AS like_number,
                    COALESCE(dd.dislike_count, 0) AS dislike_number,
                    COALESCE(dc.comment_count,0) AS comment_number,
                    EXISTS (SELECT 1 FROM discuss_like WHERE discuss_id = discuss.id AND user_id = ?) AS isLike,
                    EXISTS (SELECT 1 FROM discuss_dislike WHERE discuss_id = discuss.id AND user_id = ?) AS isDislike
                FROM
                    discuss
                LEFT JOIN
                    user AS u ON discuss.publicer_id = u.id
                LEFT JOIN
                    (SELECT discuss_id,COUNT(*) AS like_count FROM discuss_like GROUP BY discuss_id) dl ON dl.discuss_id = discuss.id
                LEFT JOIN
                    (SELECT discuss_id,COUNT(*) AS dislike_count FROM discuss_dislike GROUP BY discuss_id) dd ON dd.discuss_id = discuss.id
                LEFT JOIN
                    (SELECT discuss_id,COUNT(*) AS comment_count FROM comment GROUP BY discuss_id) dc on dc.discuss_id = discuss.id
                WHERE
                    discuss.id = ?;""";
            PreparedStatement ptmt =conn.prepareStatement(sql);
            ptmt.setInt(1, user_id);
            ptmt.setInt(2, user_id);
            ptmt.setInt(3, id);
            return ptmt.executeQuery();
        }catch (SQLException e){
            throw new SQLException(e);
        }
    }
    public static ResultSet getShowDiscussesComment(int user_id,int id) throws SQLException {
        try{
            Connection conn = connectMysql.getConnection();
            String sql = """
                    SELECT comment.*,
                            COALESCE(cl.comment_like_number, 0) AS comment_like_number,
                            EXISTS (SELECT 1 FROM comment_like WHERE comment_like.comment_id = comment.id AND user_id = ?) AS isLike,
                            user.avatar,user.user_name
                           from comment
                    LEFT JOIN
                        (SELECT comment_id,COUNT(*) AS comment_like_number FROM comment_like GROUP BY comment_id) cl on comment.id = cl.comment_id
                    LEFT JOIN
                        (SELECT id,user_name,avatar from user) user on user.id = comment.user_id
                    where discuss_id = ?""";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,user_id);
            ptmt.setInt(2,id);
            return ptmt.executeQuery();
        }catch (Exception e){
            throw new SQLException(e);
        }
    }
}
