package comY.entity;

import comY.myInterface.ResultSetExtractor;

public class User {
    private int id;
    private String user_name;
    private String password;
    private String avatar;
    private String des;

    public String getUsername() {
        return user_name;
    }

    public void setUsername(String user_name) {
        this.user_name = user_name;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getAvatar() {
        return avatar;
    }
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
    public String getDes() {
        return des;
    }
    public void setDes(String des) {
        this.des = des;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    @Override
    public String toString() {
        return "User [id=" + id + ", username=" + user_name + ", password=" + password + ", avatar=" + avatar + ", des="
                + des + "]";
    }
    public User(int id, String user_name, String password, String avatar, String des) {
        this.id = id;
        this.user_name = user_name;
        this.password = password;
        this.avatar = avatar;
        this.des = des;
    }
    public User(){
    }

    public static ResultSetExtractor<User> userAllMessageExtractor = rs -> new User(
            rs.getInt("id")
            , rs.getString("user_name")
            , rs.getString("password")
            , rs.getString("avatar")
            , rs.getString("des")
    );

    public static ResultSetExtractor<User> userLoginExtractor = rs ->{
        User user = new User();
        user.setUsername(rs.getString("user_name"));
        user.setPassword(rs.getString("password"));
        return user;
    };

    public static ResultSetExtractor<User> userBaseExtractor = rs ->{
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("user_name"));
        user.setAvatar(rs.getString("avatar"));
        user.setDes(rs.getString("des"));
        return user;
    };

}
