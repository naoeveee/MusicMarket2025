package dto;

import java.io.Serializable;

public class Music implements Serializable {

    private static final long serialVersionUID = -4274700572038677000L;

    private String musicId; // id
    private String musicTitle; // title
    private int unitPrice; // price
    private String musicSinger; // singer
    private String releaseDate; // date
    private Boolean discountCheck; // discount
    private String filename; // image file name
    private String description; // 곡 설명
    private String genre;       // 장르
    private String format;      // 음원 포맷
    private int quantity;
    private int likeCount; // 좋아요 개수

    public Music() {
        super();
    }

    public Music(String musicId, String musicTitle, Integer unitPrice) {
        this.musicId = musicId;
        this.musicTitle = musicTitle;
        this.unitPrice = unitPrice;
    }

    public String getMusicId() {
        return musicId;
    }

    public void setMusicId(String musicId) {
        this.musicId = musicId;
    }

    public String getMusicTitle() {
        return musicTitle;
    }

    public void setMusicTitle(String musicTitle) {
        this.musicTitle = musicTitle;
    }

    public int getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getMusicSinger() {
        return musicSinger;
    }

    public void setMusicSinger(String musicSinger) {
        this.musicSinger = musicSinger;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Boolean getDiscountCheck() {
        return discountCheck;
    }

    public void setDiscountCheck(Boolean discountCheck) {
        this.discountCheck = discountCheck;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // [추가] 좋아요 개수 getter/setter
    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }
}
