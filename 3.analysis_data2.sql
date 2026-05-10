SELECT 
    day_of_week,
    AVG(CASE WHEN member_casual = 'casual' THEN ride_length END) AS casual_avg_length,
    AVG(CASE WHEN member_casual = 'member' THEN ride_length END) AS member_avg_length,
    COUNT(CASE WHEN member_casual = 'casual' THEN ride_length END) AS casual_ride_count,
    COUNT(CASE WHEN member_casual = 'member' THEN ride_length END) AS member_ride_count
FROM cleaned_whole_year
WHERE day_of_week BETWEEN 1 AND 7
GROUP BY day_of_week
ORDER BY day_of_week;
