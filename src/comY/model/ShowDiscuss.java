package comY.model;

import comY.entity.Discuss;
import comY.myInterface.ResultSetExtractor;

public class ShowDiscuss extends Discuss {
    private String publicer_name;
    private String publicer_avatar;
    private Integer publicer_id;
    private Integer isLike;
    private Integer isDislike;
    private Integer like_number;
    private Integer dislike_number;
    private Integer comment_number;
    //get set
    public String getPublicer_name() {
        return publicer_name;
    }
    public void setPublicer_name(String publicer_name) {
        this.publicer_name = publicer_name;
    }
    public String getPublicer_avatar() {
        return publicer_avatar;
    }
    public void setPublicer_avatar(String publicer_avatar) {
        this.publicer_avatar = publicer_avatar;
    }
    public Integer getPublicer_id() {
        return publicer_id;
    }
    public void setPublicer_id(Integer publicer_id) {
        this.publicer_id = publicer_id;
    }
    //set get
    public Integer getIsLike() {
        return this.isLike;
    }
    public void setIsLike(Integer isLike) {
        this.isLike = isLike;
    }
    public Integer getIsDislike() {
        return this.isDislike;
    }

    public void setIsDislike(Integer isDislike) {
        this.isDislike = isDislike;
    }
    public Integer getComment_number() {
        return this.comment_number;
    }

    public void setComment_number(Integer comment_number) {
        this.comment_number = comment_number;
    }
    //like_num dislike_num get set
    public Integer getDislike_number() {
        return dislike_number;
    }
    public void setDislike_number(Integer dislike_number){
        this.dislike_number = dislike_number;
    }
    public Integer getLike_number() {
        return like_number;
    }
    public void setLike_number(Integer like_number){
        this.like_number = like_number;
    }

    public ShowDiscuss() {
    }
    public ShowDiscuss(Integer id, String title, String discuss_img, String discuss_time,
                       String discuss_main, Integer publicer_id, String publicer_name,
                       String publicer_avatar, Integer isLike, Integer isDislike, Integer like_number,
                       Integer dislike_number, Integer comment_number) {
        super(id, title, discuss_img, discuss_time, discuss_main, publicer_id);
        this.publicer_name = publicer_name;
        this.publicer_avatar = publicer_avatar;
        this.publicer_id = publicer_id;
        //补全
        this.isLike = isLike;
        this.isDislike = isDislike;
        this.like_number = like_number;
        this.dislike_number = dislike_number;
        this.comment_number = comment_number;
    }
    public static ResultSetExtractor<ShowDiscuss> userAllMessageExtractor = rs -> new ShowDiscuss(
            rs.getInt("id")
            , rs.getString("title")
            , rs.getString("discuss_img")
            , rs.getString("discuss_time")
            , rs.getString("discuss_main")
            , rs.getInt("publicer_id")
            , rs.getString("publicer_name")
            , rs.getString("publicer_avatar")
            , rs.getInt("isLike")
            , rs.getInt("isDislike")
            , rs.getInt("like_number")
            , rs.getInt("dislike_number")
            , rs.getInt("comment_number")
    );
}
