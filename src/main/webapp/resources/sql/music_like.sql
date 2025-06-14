CREATE TABLE music_like (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(50) NOT NULL,
    music_id VARCHAR(50) NOT NULL,
    UNIQUE KEY unique_like (user_id, music_id)
);
UPDATE music SET like_count = 0;
