package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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
                music.setAudioFilename(rs.getString("audio_filename"));
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
                    music.setAudioFilename(rs.getString("audio_filename"));
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
                music.setAudioFilename(rs.getString("audio_filename"));
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
                    music.setAudioFilename(rs.getString("audio_filename"));
                    list.add(music);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // [추가] 장르 기반 개인화 추천
    public List<Music> recommendForUser(String userId) {
        List<String> genres = new ArrayList<>();
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT genre, COUNT(*) as cnt " +
                "FROM music WHERE music_id IN (SELECT music_id FROM music_like WHERE user_id = ?) " +
                "GROUP BY genre ORDER BY cnt DESC"
            )
        ) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String genre = rs.getString("genre");
                if (genre != null && !genre.trim().isEmpty()) {
                    genres.add(genre);
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        if (genres.isEmpty()) return new ArrayList<>(); // 좋아요 이력이 없으면 추천 불가

        List<Music> recs = new ArrayList<>();
        StringBuilder genreIn = new StringBuilder();
        for (int i = 0; i < genres.size(); i++) {
            genreIn.append("?");
            if (i < genres.size() - 1) genreIn.append(",");
        }
        String sql = "SELECT * FROM music WHERE genre IN (" + genreIn + ") " +
                     "AND music_id NOT IN (SELECT music_id FROM music_like WHERE user_id = ?) " +
                     "ORDER BY like_count DESC LIMIT 10";
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            int idx = 1;
            for (String g : genres) pstmt.setString(idx++, g);
            pstmt.setString(idx, userId);
            ResultSet rs = pstmt.executeQuery();
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
                music.setAudioFilename(rs.getString("audio_filename"));
                recs.add(music);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return recs;
    }

    // [추가] 협업 필터링 기반 추천
    public List<Music> recommendCollaborative(String userId) {
        List<Music> recs = new ArrayList<>();
        String sql =
            "SELECT m.*, COUNT(*) AS score " +
            "FROM music m JOIN music_like l ON m.music_id = l.music_id " +
            "WHERE l.user_id IN ( " +
            "   SELECT DISTINCT user_id FROM music_like " +
            "   WHERE music_id IN (SELECT music_id FROM music_like WHERE user_id = ?) AND user_id != ? " +
            ") " +
            "AND m.music_id NOT IN (SELECT music_id FROM music_like WHERE user_id = ?) " +
            "GROUP BY m.music_id " +
            "ORDER BY score DESC, m.like_count DESC " +
            "LIMIT 10";
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, userId);
            pstmt.setString(2, userId);
            pstmt.setString(3, userId);
            ResultSet rs = pstmt.executeQuery();
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
                music.setAudioFilename(rs.getString("audio_filename"));
                recs.add(music);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return recs;
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

    // [플레이리스트] '구매한 곡' 플레이리스트 ID 조회(없으면 생성)
    public int getOrCreatePurchasedPlaylistId(String userId) {
        int playlistId = -1;
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT playlist_id FROM playlist WHERE user_id = ? AND playlist_name = '구매한 곡'")
        ) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                playlistId = rs.getInt("playlist_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (playlistId == -1) {
            try (
                Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(
                    "INSERT INTO playlist (user_id, playlist_name) VALUES (?, '구매한 곡')",
                    Statement.RETURN_GENERATED_KEYS)
            ) {
                pstmt.setString(1, userId);
                pstmt.executeUpdate();
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    playlistId = rs.getInt(1);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return playlistId;
    }

    // [플레이리스트] 곡을 플레이리스트에 추가(중복 방지)
    public void addMusicToPlaylistIfNotExists(int playlistId, String musicId) {
        boolean exists = false;
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT 1 FROM playlist_music WHERE playlist_id = ? AND music_id = ?")
        ) {
            pstmt.setInt(1, playlistId);
            pstmt.setString(2, musicId);
            ResultSet rs = pstmt.executeQuery();
            exists = rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (!exists) {
            try (
                Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(
                    "INSERT INTO playlist_music (playlist_id, music_id) VALUES (?, ?)")
            ) {
                pstmt.setInt(1, playlistId);
                pstmt.setString(2, musicId);
                pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // [플레이리스트] 플레이리스트의 곡 목록 조회
    public List<Music> getPlaylistMusics(int playlistId) {
        List<Music> list = new ArrayList<>();
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT m.* FROM music m JOIN playlist_music pm ON m.music_id = pm.music_id WHERE pm.playlist_id = ?")
        ) {
            pstmt.setInt(1, playlistId);
            ResultSet rs = pstmt.executeQuery();
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
                music.setAudioFilename(rs.getString("audio_filename"));
                list.add(music);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    // 플레이리스트 곡 삭제
    public void removeMusicFromPlaylist(int playlistId, String musicId) {
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "DELETE FROM playlist_music WHERE playlist_id = ? AND music_id = ?")
        ) {
            pstmt.setInt(1, playlistId);
            pstmt.setString(2, musicId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
