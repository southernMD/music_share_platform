package comY.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import comY.entity.User;
import comY.util.MD5SaltUtil;
import comY.util.connectMysql;

public class loginDao {

    public static User login(String username,String password) throws SQLException{
        Connection conn = connectMysql.getConnection();
        String sql = "select * from user where user_name = ? and password = ?";
        PreparedStatement ptmt = conn.prepareStatement(sql);
        ptmt.setString(1, username);
        ptmt.setString(2, MD5SaltUtil.generateMD5HashWithSalt(password));
        ResultSet rs = ptmt.executeQuery();
        List<User> resultList = connectMysql.queryToArrayList(rs, User.userAllMessageExtractor);
        if(resultList.isEmpty()){
            throw new SQLException("对象不存在或输入账号密码有误");
        }else{
            return resultList.get(0);
        }
    }
}
