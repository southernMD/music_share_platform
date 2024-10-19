package comY.model;
import comY.entity.Comment;
import comY.myInterface.ResultSetExtractor;

public class ShowComment extends Comment {
    private String comment_like_number;
    private String isLike;
    private String user_name;
    private String avatar;
    //get sert
    public String getComment_like_number() {
        return comment_like_number;
    }
    public void setComment_like_number(String comment_like_number) {
        this.comment_like_number = comment_like_number;
    }
    public String getIsLike() {
        return isLike;
    }
    public void setIsLike(String isLike) {
        this.isLike = isLike;
    }

    public String getUser_name() {
        return user_name;
    }
    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
    public String getAvatar() {
        return avatar;
    }
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public ShowComment() {
    }

    public ShowComment(int id, String comment_time, int discuss_id, String message,
                       int user_id, String comment_like_number, String isLike,
                       String avatar, String user_name) {
        super(id, comment_time, discuss_id, message, user_id);
        this.comment_like_number = comment_like_number;
        this.isLike = isLike;
        this.user_name = user_name;
        this.avatar = avatar;
    }

    public static ResultSetExtractor<ShowComment> userAllMessageExtractor = rs -> new ShowComment(
            rs.getInt("id")
            , rs.getString("comment_time")
            , rs.getInt("discuss_id")
            , rs.getString("message")
            , rs.getInt("user_id")
            , rs.getString("comment_like_number")
            , rs.getString("isLike")
            , rs.getString("avatar")
            , rs.getString("user_name")
    );
}
