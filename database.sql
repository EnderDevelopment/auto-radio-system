CREATE TABLE IF NOT EXISTS `autoradio` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT NOT NULL,
    `youtube_link` VARCHAR(255) NOT NULL,
    `volume` FLOAT NOT NULL DEFAULT 0.5,
    `is_playing` BOOLEAN NOT NULL DEFAULT FALSE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO `autoradio` (`player_id`, `youtube_link`, `volume`, `is_playing`) VALUES
(1, 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', 0.5, FALSE);