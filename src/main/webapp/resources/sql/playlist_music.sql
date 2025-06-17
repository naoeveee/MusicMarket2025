CREATE TABLE playlist_music (
    playlist_id INT,
    music_id VARCHAR(20),
    PRIMARY KEY (playlist_id, music_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id) ON DELETE CASCADE,
    FOREIGN KEY (music_id) REFERENCES music(music_id) ON DELETE CASCADE
);
