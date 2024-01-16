-- Identify duplicate ride_ids
WITH Duplicates AS (
  SELECT ride_id
  FROM combined_data
  GROUP BY ride_id
  HAVING COUNT(*) > 1
)
-- Delete duplicate rows
DELETE FROM combined_data
	WHERE ride_id IN (SELECT ride_id FROM Duplicates);
	---- creating a clean combined table, had errors coming up while using CREATE TABLE with SELECT command
	---- So I instead created an empty table and then went ahead using the INSERT INTO function
	DROP TABLE cleaned_combined_data

CREATE TABLE cleaned_combined_data
(
  ride_id NVARCHAR(255) NOT NULL,
  rideable_type NVARCHAR(255), 
  started_at DATETIME,
  ended_at DATETIME,
  ride_length INT, 
  day_of_week NVARCHAR(50), 
  month NVARCHAR(50),
  start_station_name NVARCHAR(255), 
  end_station_name NVARCHAR(255), 
  start_lat FLOAT, 
  start_lng FLOAT, 
  end_lat FLOAT,
  end_lng FLOAT, 
  member_casual NVARCHAR(50) 
);

INSERT INTO cleaned_combined_data
SELECT 
  a.ride_id, rideable_type, started_at, ended_at, 
  DATEDIFF(MINUTE, started_at, ended_at) AS ride_length,
  CASE DATEPART(WEEKDAY, started_at) 
    WHEN 1 THEN 'SUN'
    WHEN 2 THEN 'MON'
    WHEN 3 THEN 'TUES'
    WHEN 4 THEN 'WED'
    WHEN 5 THEN 'THURS'
    WHEN 6 THEN 'FRI'
    WHEN 7 THEN 'SAT'    
  END AS day_of_week,
  DATENAME(MONTH, started_at) AS month,
  start_station_name, end_station_name, 
  start_lat, start_lng, end_lat, end_lng, member_casual
FROM combined_data a ---defining an alias
JOIN (
    SELECT 
      ride_id, 
      DATEDIFF(MINUTE, started_at, ended_at) AS ride_length
    FROM combined_data
) b ON a.ride_id = b.ride_id;
---the adding primary key command will not work on a nullable column 
---so I added NOT NULL in the create table code chunk
ALTER TABLE cleaned_combined_data
ADD PRIMARY KEY(ride_id);--making ride id primary key for the cleaned_combined_data

SELECT COUNT(ride_id) AS no_of_rows
FROM cleaned_combined_data
WHERE 
  start_station_name IS NOT NULL AND
  end_station_name IS NOT NULL AND
  end_lat IS NOT NULL AND
  end_lng IS NOT NULL AND
  ride_length > 1 AND ride_length < 1440; --excluding rides that are more than a day
  --Total rows come out to be 4263281 rows
  DELETE 
  FROM cleaned_combined_data
  WHERE
  start_station_name IS NULL OR
  end_station_name IS NULL OR
  end_lat IS NULL OR
  end_lng IS NULL OR
  ride_length < 1 OR ride_length >1440;
	
