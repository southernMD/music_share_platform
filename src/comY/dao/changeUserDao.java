package comY.dao;

import comY.entity.User;
import comY.util.MD5SaltUtil;
import comY.util.connectMysql;
import comY.util.getSaveFilePath;

import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class changeUserDao {
    public static String saveFile(Part part,String path,Integer id){
        //判断part是不是含有一个文件对象
        try {
            System.out.println("part_size:"+part.getSize());
            if(part.getSize()==0){
                Connection conn = connectMysql.getConnection();
                String sql = "select avatar from user where id = ?";
                PreparedStatement ptmt = conn.prepareStatement(sql);
                ptmt.setInt(1, id);
                ResultSet rs = ptmt.executeQuery();
                rs.next();
                return rs.getString("avatar");
            }else{
                return "/files/" + getSaveFilePath.getPath(part,path);
            }
        }catch (Exception e){
            System.out.print(e);
            return "/public/vite.svg";
        }
    }

    public static List<User> changeUser(Integer id, String username, String description, String avatar) throws SQLException {
        Connection conn = connectMysql.getConnection();
        String sql = "update user set user_name=?,des=?,avatar=? where id=?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setString(1, username);
        ptmt.setString(2, description);
        ptmt.setString(3, avatar);
        ptmt.setInt(4, id);
        int t = ptmt.executeUpdate();
        if(t==1){
            String sql2 = "select * from user where id=?";
            PreparedStatement ptmt2 = conn.prepareStatement(sql2);
            ptmt2.setInt(1,id);
            ResultSet rs = ptmt2.executeQuery();
            return connectMysql.queryToArrayList(rs, User.userAllMessageExtractor);
        }else{
            throw new SQLException("修改失败");
        }

    }
    public static void checkUser(String username,Integer id) throws SQLException{
        if (username.isEmpty()){
            throw new SQLException("用户名不能为空");
        }else{
            Connection conn = connectMysql.getConnection();
            String sql = "select * from user where user_name=? and id != ?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, username);
            ptmt.setInt(2, id);
            ResultSet rs = ptmt.executeQuery();
            if(rs.next()){
                throw new SQLException("用户名已存在");
            }
        }
    }
}
