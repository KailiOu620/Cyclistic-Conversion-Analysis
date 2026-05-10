#总体：区别不同种类用户的平均骑行长度,最大值,最小值，众数，中位数骑行次数，count(rideable_type)
SELECT member_casual,AVG(ride_length) AS avg_ride_length,MAX(ride_length) AS max_ride_length,
		MIN(ride_length) AS min_ride_length, COUNT(ride_id) AS whole_ride_number,
        (SELECT ride_length
        FROM cleaned_whole_year t2
        WHERE t2.member_casual = t1.member_casual
        GROUP BY ride_length
        ORDER BY COUNT(*) DESC
        LIMIT 1) AS mode_rider_length,
       (SELECT AVG(t.ride_length)
       FROM (
         SELECT
             ride_length,
             ROW_NUMBER() OVER(ORDER BY ride_length) AS rn,
             COUNT(*) OVER() AS cnt
         FROM cleaned_whole_year t3
         WHERE t3.member_casual = t1.member_casual
       ) AS t
       WHERE t.rn IN (FLOOR((t.cnt + 1)/2), CEIL((t.cnt + 1)/2))) AS median_ride_length,
       COUNT(CASE WHEN rideable_type = 'classic_bike' THEN 1 END) AS whole_classic_bike_num,
	   COUNT(CASE WHEN rideable_type = 'electric_bike' THEN 1 END) AS whole_electric_bike_num
FROM cleaned_whole_year t1
GROUP BY member_casual
ORDER BY member_casual;

