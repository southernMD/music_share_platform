package comY.dao;

import comY.entity.User;
import comY.util.MD5SaltUtil;
import comY.util.connectMysql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class regDao {
    public static User Reg(String username, String password) throws SQLException {
        Connection conn = connectMysql.getConnection();
        String sql = "select * from user where user_name = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setString(1, username);
        ResultSet rs = ptmt.executeQuery();
        if(!connectMysql.queryToArrayList(rs, comY.entity.User.userAllMessageExtractor).isEmpty()){
            throw new SQLException("用户名已存在");
        }else{
            String sql2 = "insert into user (user_name,password,avatar) values(?,?,'/public/vite.svg')";
            ptmt = conn.prepareStatement(sql2);
            ptmt.setString(1, username);
            ptmt.setString(2, MD5SaltUtil.generateMD5HashWithSalt(password));
            int t = ptmt.executeUpdate();
            if(t!=1){
                throw new SQLException("注册失败");
            }else{
                return loginDao.login(username,password);
            }
        }
    }
}
