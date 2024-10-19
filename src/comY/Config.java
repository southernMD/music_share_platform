package comY;

public enum Config {

    HOST_URL("jdbc:mysql://localhost:3306/music_share_platform"),
    USER("root"),
    PASSWORD("m123042012"),
    SALT("southernMD"),
    PageSize("5");

    private String value;

    Config(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}