package dao;

import java.sql.*;
import java.util.ArrayList;
import dto.Music;

public class MusicRepository {


    private static MusicRepository instance = new MusicRepository();

    public static MusicRepository getInstance() {
        return instance;
    }

    // DB에서 모든 음악 목록을 읽어옴
    public ArrayList<Music> getAllMusics() {
        ArrayList<Music> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            // DB 연결 정보는 실제 환경에 맞게 수정하세요
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/MusicMarketDB",
                "root", "1234"
            );
            String sql = "SELECT * FROM music";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Music music = new Music(
                    rs.getString("music_id"),
                    rs.getString("music_title"),
                    rs.getInt("unit_price")
                );
                music.setMusicSinger(rs.getString("music_singer"));
                music.setReleaseDate(rs.getString("release_date"));
                music.setDiscountCheck(rs.getBoolean("discount_check"));
                music.setFilename(rs.getString("filename"));
                music.setDescription(rs.getString("description"));
                music.setGenre(rs.getString("genre"));
                music.setFormat(rs.getString("format"));
                list.add(music);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return list;
    }

    // DB에서 music_id로 음악 한 곡을 읽어옴
    public Music getMusicById(String musicId) {
        Music music = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
            		 "jdbc:mysql://localhost:3306/MusicMarketDB",
                     "root", "1234"
            );
            String sql = "SELECT * FROM music WHERE music_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, musicId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                music = new Music(
                    rs.getString("music_id"),
                    rs.getString("music_title"),
                    rs.getInt("unit_price")
                );
                music.setMusicSinger(rs.getString("music_singer"));
                music.setReleaseDate(rs.getString("release_date"));
                music.setDiscountCheck(rs.getBoolean("discount_check"));
                music.setFilename(rs.getString("filename"));
                music.setDescription(rs.getString("description"));
                music.setGenre(rs.getString("genre"));
                music.setFormat(rs.getString("format"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return music;
    }
}
