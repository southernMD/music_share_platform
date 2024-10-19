package comY.dao;

import comY.util.connectMysql;
import comY.util.getSaveFilePath;

import javax.servlet.http.Part;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class updateSongDetailDao {

    public static void updateSongDetail(Integer id,String song_name,String ar_name,String song_url,String song_lrc,String song_des,String img_url,Integer user_id) {
        try {
            Connection conn = connectMysql.getConnection();
            String sql="";
            Object[] params;
            if(img_url.equals("/public/images/image.jpg")){
                sql = "update songs set song_name=?,ar_name=?,song_url=?,lrc=?,song_des=? where id = ? and user_id = ?";
                params = new Object[]{song_name,ar_name,song_url,song_lrc,song_des,id,user_id};
            }else{
                sql = "update songs set song_name=?,ar_name=?,song_url=?,lrc=?,song_des=?,song_img = ? where id = ? and user_id = ?";
                params = new Object[]{song_name,ar_name,song_url,song_lrc,song_des,img_url,id,user_id};
            }
            PreparedStatement ptmt = conn.prepareStatement(sql);
            for (int i = 0; i < params.length; i++) {
                ptmt.setObject(i + 1, params[i]);
            }
            int t = ptmt.executeUpdate();
            if(t==1){
                System.out.println("修改成功");
            }else{
                throw new Exception("修改失败");
            }
        }catch (Exception e){
            throw new RuntimeException(e.toString());
        }
    }
}
