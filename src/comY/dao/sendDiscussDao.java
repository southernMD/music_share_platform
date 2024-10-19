package comY.dao;

import comY.util.connectMysql;
import comY.util.getTime;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class sendDiscussDao {
    public static void sendDiscuss(String title ,String txt, Integer publicer_id,String img_url) {
        try {
            Connection conn = connectMysql.getConnection();
            String sql = "INSERT INTO discuss (title, discuss_img, discuss_time, discuss_main, publicer_id) VALUES (?,?,?,?,?)";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, title);
            ptmt.setString(2, img_url);
            ptmt.setTimestamp(3, getTime.getNowTime());
            ptmt.setString(4, txt);
            ptmt.setInt(5, publicer_id);
            int t = ptmt.executeUpdate();
            if (t != 1) {
                throw new SQLException();
            }
            System.out.println( getTime.getNowTime());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
