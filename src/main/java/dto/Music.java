package dto;

import java.io.Serializable;

public class Music implements Serializable {

	private static final long serialVersionUID=-4274700572038677000L;
	
	private String musicId; //id
	private String musicTitle; //title
	private int unitPrice; //price
	private String musicSinger; //singer
	private String releaseDate; //date
	private Boolean discountCheck; //discount
	private String filename; //image file name
	private int quantity; //장바구니에 담은 음악 개수
	

	public Music() {
		super();
	}
	
	public Music(String musicId, String musicTitle, Integer unitPrice) {
		this.musicId=musicId;
		this.musicTitle=musicTitle;
		this.unitPrice=unitPrice;
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
	
	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	
}
