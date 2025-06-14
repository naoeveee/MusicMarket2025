package dao;

import java.sql.*;
import java.util.ArrayList;
import dto.Music;

public class MusicRepository {

    private static MusicRepository instance = new MusicRepository();

    public static MusicRepository getInstance() {
        return instance;
    }

    // DB 연결 메서드 (중복 제거용)
    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/MusicMarketDB",
            "root", "1234"
        );
    }

    // DB에서 모든 음악 목록을 읽어옴
    public ArrayList<Music> getAllMusics() {
        ArrayList<Music> list = new ArrayList<>();
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM music");
            ResultSet rs = pstmt.executeQuery()
        ) {
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
                music.setLikeCount(rs.getInt("like_count"));
                list.add(music);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // DB에서 music_id로 음악 한 곡을 읽어옴
    public Music getMusicById(String musicId) {
        Music music = null;
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM music WHERE music_id = ?")
        ) {
            pstmt.setString(1, musicId);
            try (ResultSet rs = pstmt.executeQuery()) {
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
                    music.setLikeCount(rs.getInt("like_count"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return music;
    }

    // 최신순으로 정렬된 음악 목록 가져오기
    public ArrayList<Music> getNewMusics() {
        ArrayList<Music> list = new ArrayList<>();
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM music ORDER BY release_date DESC");
            ResultSet rs = pstmt.executeQuery()
        ) {
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
                music.setLikeCount(rs.getInt("like_count"));
                list.add(music);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 검색 기능: 제목/가수/장르로 검색
    public ArrayList<Music> searchMusics(String field, String keyword) {
        ArrayList<Music> list = new ArrayList<>();
        if (!("music_title".equals(field) || "music_singer".equals(field) || "genre".equals(field))) {
            return list;
        }
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM music WHERE " + field + " LIKE ?")
        ) {
            pstmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
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
                    music.setLikeCount(rs.getInt("like_count"));
                    list.add(music);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 좋아요 개수 증가
    public void increaseLike(String musicId) {
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "UPDATE music SET like_count = like_count + 1 WHERE music_id = ?")
        ) {
            pstmt.setString(1, musicId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 좋아요 개수 감소 (최소 0)
    public void decreaseLike(String musicId) {
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "UPDATE music SET like_count = like_count - 1 WHERE music_id = ? AND like_count > 0")
        ) {
            pstmt.setString(1, musicId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 좋아요 기록 추가 (music_like 테이블)
    public void insertMusicLike(String userId, String musicId) {
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "INSERT INTO music_like(user_id, music_id) VALUES (?, ?)")
        ) {
            pstmt.setString(1, userId);
            pstmt.setString(2, musicId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            // 중복 좋아요는 무시 (UNIQUE 제약조건 위반)
        }
    }

    // 좋아요 기록 삭제 (music_like 테이블)
    public void deleteMusicLike(String userId, String musicId) {
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "DELETE FROM music_like WHERE user_id = ? AND music_id = ?")
        ) {
            pstmt.setString(1, userId);
            pstmt.setString(2, musicId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 이미 좋아요 했는지 확인
    public boolean hasLiked(String userId, String musicId) {
        boolean result = false;
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT 1 FROM music_like WHERE user_id = ? AND music_id = ?")
        ) {
            pstmt.setString(1, userId);
            pstmt.setString(2, musicId);
            try (ResultSet rs = pstmt.executeQuery()) {
                result = rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
