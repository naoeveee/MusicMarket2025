
package dao;

import java.util.ArrayList;
import dto.Music;

public class MusicRepository {
	
	private ArrayList<Music> listOfMusics = new ArrayList<Music>();
	private static MusicRepository instance=new MusicRepository();
	
	public static MusicRepository getInstance() {
		return instance;
	}
	
	public MusicRepository() {
		Music music1 = new Music("01","무제", 5900);
		music1.setMusicSinger("지드래곤");
		music1.setReleaseDate("2025-04-05");
		music1.setDiscountCheck(false);
		music1.setFilename("music1.jpg");
		music1.setDescription("지드래곤의 감성적인 곡입니다.");
		music1.setGenre("힙합");
		music1.setFormat("CD");
		
	

		Music music2 = new Music("02","LOVE DIVE", 6500);
		music2.setMusicSinger("IVE");
		music2.setReleaseDate("2024-11-13");
		music2.setDiscountCheck(true);
		music2.setFilename("music2.jpg");
		music2.setDescription("IVE의 대표 히트곡 LOVE DIVE");
		music2.setGenre("댄스");
		music2.setFormat("MP3");


		
		Music music3 = new Music("03","봄날", 3500);
		music3.setMusicSinger("BTS");
		music3.setReleaseDate("2021-08-21");
		music3.setDiscountCheck(false);
		music3.setFilename("music3.jpg");
		music3.setDescription("BTS의 따뜻한 봄 노래입니다.");
		music3.setGenre("댄스");
		music3.setFormat("Streaming");
		
		

		listOfMusics.add(music1);
		listOfMusics.add(music2);
		listOfMusics.add(music3);
		
	}
	
	public ArrayList<Music> getAllMusics(){
		return listOfMusics;
	}
	
	public Music getMusicById(String musicId) {
		Music musicById=null;
		
		for(int i=0; i<listOfMusics.size();i++) {
			Music music= listOfMusics.get(i);
			if(music!=null && music.getMusicId()!=null && music.getMusicId().equals(musicId)) {
				musicById=music;
				break;
			}
		}
		return musicById;
	}

}
