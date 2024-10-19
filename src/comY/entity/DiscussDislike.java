package comY.entity;

import comY.myInterface.ResultSetExtractor;

public class DiscussDislike extends DiscussLike{
    public DiscussDislike() {}
    public DiscussDislike(Integer discuss_id, Integer user_id) {
        super(discuss_id, user_id);
    }
    public static ResultSetExtractor<DiscussDislike> userAllMessageExtractor = rs -> new DiscussDislike(
            rs.getInt("discuss_id"),
            rs.getInt("user_id")
    );
}
