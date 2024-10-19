package comY.entity;

import comY.myInterface.ResultSetExtractor;

public class Comment {
    private int id;
    private String comment_time;
    private int discuss_id;
    private String message;
    private int user_id;
    //get set
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getComment_time() {
        return comment_time;
    }
    public void setComment_time(String comment_time) {
        this.comment_time = comment_time;
    }
    public int getDiscuss_id() {
        return discuss_id;
    }
    public void setDiscuss_id(int discuss_id) {
        this.discuss_id = discuss_id;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", comment_time='" + comment_time + '\'' +
                ", discuss_id=" + discuss_id +
                ", message='" + message + '\'' +
                ", user_id='" + user_id + '\'' +
                '}';
    }
    public Comment() {
    }

    public Comment(int id, String comment_time, int discuss_id, String message, int user_id) {
        this.id = id;
        this.comment_time = comment_time;
        this.discuss_id = discuss_id;
        this.message = message;
        this.user_id = user_id;
    }

    public static ResultSetExtractor<Comment> userAllMessageExtractor = rs -> new Comment(
            rs.getInt("id")
            , rs.getString("comment_time")
            , rs.getInt("discuss_id")
            , rs.getString("message")
            , rs.getInt("user_id")
    );
}
