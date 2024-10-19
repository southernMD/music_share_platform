package comY.entity;

import comY.myInterface.ResultSetExtractor;

public class Song {
    private Integer id;
    private String public_time;
    private String song_img;
    private String song_name;
    private String song_url;
    private String song_lrc;
    private String ar_name;
    private String lrc;
    private String song_des;
    private Integer user_id;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getPublic_time() {
        return public_time;
    }
    public void setPublic_time(String public_time) {
        this.public_time = public_time;
    }
    public String getSong_img() {
        return song_img;
    }
    public void setSong_img(String song_img) {
        this.song_img = song_img;
    }
    public String getSong_name() {
        return song_name;
    }
    public void setSong_name(String song_name) {
        this.song_name = song_name;
    }
    public String getSong_url() {
        return song_url;
    }
    public void setSong_url(String song_url) {
        this.song_url = song_url;
    }
    public String getSong_lrc() {
        return song_lrc;
    }
    public void setSong_lrc(String song_lrc) {
        this.song_lrc = song_lrc;
    }
    public String getAr_name() {
        return ar_name;
    }
    public void setAr_name(String ar_name) {
        this.ar_name = ar_name;
    }
    public String getLrc() {
        return lrc;
    }
    public void setLrc(String lrc) {
        this.lrc = lrc;
    }
    public String getSong_des() {
        return song_des;
    }
    public void setSong_des(String song_des) {
        this.song_des = song_des;
    }
    public Integer getUser_id() {
        return user_id;
    }
    public void setUser_id(Integer user_id){
        this.user_id = user_id;
    }
    public Song(){}
    //有参构造器
    public Song(Integer id, String public_time, String song_img, String song_name, String song_url, String ar_name, String lrc, String song_des, Integer user_id) {
        this.id = id;
        this.public_time = public_time;
        this.song_img = song_img;
        this.song_name = song_name;
        this.song_url = song_url;
        this.ar_name = ar_name;
        this.lrc = lrc;
        this.song_des = song_des;
        this.user_id = user_id;
    }
    public static ResultSetExtractor<Song> userAllMessageExtractor = rs -> new Song(
            rs.getInt("id")
            , rs.getString("public_time")
            , rs.getString("song_img")
            , rs.getString("song_name")
            , rs.getString("song_url")
            , rs.getString("ar_name")
            , rs.getString("lrc")
            , rs.getString("song_des")
            , rs.getInt("user_id")
    );

}
