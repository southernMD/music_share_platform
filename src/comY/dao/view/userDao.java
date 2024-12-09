package comY.dao.view;

import comY.entity.Discuss;
import comY.entity.Song;
import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class userDao {
    public static ResultSet getUserMsg(int id) throws SQLException {
        try{
            Connection conn = connectMysql.getConnection();
            String sql = "SELECT id,user_name,avatar,des from user where id = ?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, id);
            return ptmt.executeQuery();
        }catch (Exception e){
            throw new SQLException(e);
        }
    }

    public static ResultSet getUserPublicSong(int id) throws SQLException {
        try{
            Connection conn = connectMysql.getConnection();
            String sql = "SELECT * from songs where user_id = ?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,id);
            return ptmt.executeQuery();
        }catch (Exception e){
            throw new SQLException(e);
        }
    }

    public static ResultSet getUserPublicDiscuss(int id) throws SQLException {
        try{
            Connection conn = connectMysql.getConnection();
            String sql = "SELECT * from discuss where publicer_id = ?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, id);
            return ptmt.executeQuery();
        }catch (Exception e){
            throw new SQLException(e);
        }
    }
}
