-- 新增自增主键列=
ALTER TABLE cleaned_whole_year1
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

CREATE INDEX idx_station_member_week_duration 
ON cleaned_whole_year1 (start_station_name, member_casual, day_of_week, ride_length_seconds);

CREATE INDEX idx_ride_type ON cleaned_whole_year1 (rideable_type);
