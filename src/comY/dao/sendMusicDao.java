package comY.dao;

import comY.util.connectMysql;
import comY.util.getSaveFilePath;
import comY.util.getTime;

import javax.servlet.http.Part;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class sendMusicDao {

    public static void sendMusic(String song_name, String ar_name, String song_url, String song_lrc, String song_des, String img_url, Integer user_id)  {
        try {
            Connection conn = connectMysql.getConnection();
            String sql = "INSERT INTO songs (public_time, song_img, song_name, song_url, ar_name, lrc, song_des, user_id) VALUES (?,?,?,?,?,?,?,?)";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            System.out.println( getTime.getNowTime());
            ptmt.setTimestamp(1, getTime.getNowTime());
            ptmt.setString(2, img_url);
            ptmt.setString(3, song_name);
            ptmt.setString(4, song_url);
            ptmt.setString(5, ar_name);
            ptmt.setString(6, song_lrc);
            ptmt.setString(7, song_des);
            ptmt.setInt(8, user_id);
            int t = ptmt.executeUpdate();
            System.out.println(t);
            if (t != 1) {
                throw new Exception("发送失败");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
