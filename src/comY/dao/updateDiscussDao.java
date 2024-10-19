package comY.dao;

import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class updateDiscussDao {
    public static void updateDiscuss(Integer id,String title,String discuss_img,String discuss_main,Integer publicer_id)
    {
        try {
            Connection conn = connectMysql.getConnection();
            String sql="";
            Object[] params;
            if(discuss_img.equals("/public/images/image.jpg")){
                sql = "update discuss set title=?,discuss_main=? where id = ? and publicer_id = ?";
                params = new Object[]{title,discuss_main,id,publicer_id};
            }else{
                sql = "update discuss set title=?,discuss_img=?,discuss_main=? where id = ? and publicer_id = ?";
                params = new Object[]{title,discuss_img,discuss_main,id,publicer_id};
            }
            PreparedStatement ptmt = conn.prepareStatement(sql);
            for (int i = 0; i < params.length; i++) {
                ptmt.setObject(i + 1, params[i]);
            }
            int t = ptmt.executeUpdate();
            if(t==1){
                System.out.println("修改成功");
            }else{
                throw new SQLException("修改失败");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
