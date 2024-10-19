package comY.entity;

import comY.myInterface.ResultSetExtractor;

public class Discuss {
    private Integer id;
    private String title;
    private String discuss_img;
    private String discuss_time;
    private String discuss_main;
    private Integer publicer_id;
    //get set
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getDiscuss_img() {
        return discuss_img;
    }
    public void setDiscuss_img(String discuss_img) {
        this.discuss_img = discuss_img;
    }
    public String getDiscuss_time() {
        return discuss_time;
    }
    public void setDiscuss_time(String discuss_time) {
        this.discuss_time = discuss_time;
    }

    public String getDiscuss_main() {
        return discuss_main;
    }

    public void setDiscuss_main(String discuss_main) {
        this.discuss_main = discuss_main;
    }
    public Integer getPublicer_id() {
        return publicer_id;
    }
    public void setPublicer_id(Integer publicer_id) {
        this.publicer_id = publicer_id;
    }
    //构造器
    public Discuss() {
    }

    public Discuss(Integer id, String title, String discuss_img, String discuss_time, String discuss_main, Integer publicer_id)
    {
        this.id = id;
        this.title = title;
        this.discuss_img = discuss_img;
        this.discuss_time = discuss_time;
        this.discuss_main = discuss_main;
        this.publicer_id = publicer_id;
    }
    public static ResultSetExtractor<Discuss> userAllMessageExtractor = rs -> new Discuss(
            rs.getInt("id")
            , rs.getString("title")
            , rs.getString("discuss_img")
            , rs.getString("discuss_time")
            , rs.getString("discuss_main")
            , rs.getInt("publicer_id")
    );
}
