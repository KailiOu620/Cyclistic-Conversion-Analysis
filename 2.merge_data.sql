CREATE DATABASE case1;
USE case1;
CREATE TABLE cleaned2207(ride_id VARCHAR(50) NOT NULL PRIMARY KEY COMMENT '骑行唯一ID',
						rideable_type VARCHAR(20),
						started_at DATETIME,
						ended_at DATETIME NOT NULL,
						start_station_name VARCHAR(100),
						start_station_id VARCHAR(20),
						end_station_name VARCHAR(100),
						end_station_id VARCHAR(20),
						start_lat DECIMAL(9,6),
						start_lng DECIMAL(9,6),
						end_lat DECIMAL(9,6),
						end_lng DECIMAL(9,6),
						member_casual VARCHAR(10),
						ride_length_seconds INT UNSIGNED,
						ride_length_time TIME,
						day_of_week TINYINT);
SHOW TABLES;
USE case1;
TRUNCATE TABLE cleaned2207;

LOAD DATA LOCAL INFILE 'C:/Users/区凯丽/Desktop/CASE1/数据/cleand_data/cleaned_202207_data.csv'
INTO TABLE cleaned2207
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'  -- 修正：单引号包裹双引号，避免语法错误
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 验证数据
SELECT * FROM cleaned2207 LIMIT 10;


