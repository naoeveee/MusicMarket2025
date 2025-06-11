CREATE TABLE music (
    music_id      VARCHAR(20)  PRIMARY KEY,
    music_title   VARCHAR(100) NOT NULL,
    unit_price    INT          NOT NULL,
    music_singer  VARCHAR(100),
    release_date  DATE,
    discount_check BOOLEAN,
    filename      VARCHAR(200),
    description   TEXT,
    genre         VARCHAR(50),
    format        VARCHAR(50)
);
