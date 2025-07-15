-- Create databases for Moodle and WordPress
CREATE DATABASE IF NOT EXISTS moodle_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create user for wordpress
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_pass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';

-- Root user privileges for Moodle
GRANT ALL PRIVILEGES ON moodle_db.* TO 'root'@'%';

FLUSH PRIVILEGES;
