package comY.entity;

import comY.myInterface.ResultSetExtractor;

public class DiscussLike {
    private Integer discuss_id;
    private Integer user_id;
    //set get
    public Integer getDiscuss_id() {
        return discuss_id;
    }
    public void setDiscuss_id(Integer discuss_id) {
        this.discuss_id = discuss_id;
    }
    public Integer getUser_id() {
        return user_id;
    }
    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }
    public DiscussLike() {}
    public DiscussLike(Integer discuss_id, Integer user_id) {
        this.discuss_id = discuss_id;
        this.user_id = user_id;
    }

    public static ResultSetExtractor<DiscussLike> userAllMessageExtractor = rs -> new DiscussLike(
            rs.getInt("discuss_id")
            , rs.getInt("user_id")
    );

}
