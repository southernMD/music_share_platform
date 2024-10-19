package comY.dao;

import comY.Config;
import comY.entity.Song;
import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class searchSongDao {
    public static List<Song> searchSong(String search, int nowPage) throws SQLException {
        String sql = "SELECT * FROM songs\n" +
                "WHERE song_name like ? or songs.ar_name like ?\n" +
                "ORDER BY public_time\n" +
                "DESC\n" +
                "LIMIT ?,5";
        Connection connection = connectMysql.getConnection();
        PreparedStatement ptmt = connection.prepareStatement(sql);
        ptmt.setString(1,"%"+search+"%");
        ptmt.setString(2, "%"+search+"%");
        ptmt.setInt(3, (nowPage-1)*Integer.parseInt(Config.PageSize.getValue()));
        ResultSet rs = ptmt.executeQuery();
        return connectMysql.queryToArrayList(rs, Song.userAllMessageExtractor);
    }
    public static ResultSet getSearchSongCount(String search) throws SQLException {
        String sql = "SELECT count(*) as totalItems,ceil(count(*)/?) as totalPage from songs\n" +
                "WHERE song_name like ? or songs.ar_name like ?";
        Connection connection = connectMysql.getConnection();
        PreparedStatement ptmt = connection.prepareStatement(sql);
        ptmt.setInt(1,Integer.parseInt(Config.PageSize.getValue()));
        ptmt.setString(2,"%"+search+"%");
        ptmt.setString(3, "%"+search+"%");
        return ptmt.executeQuery();
    }
}
