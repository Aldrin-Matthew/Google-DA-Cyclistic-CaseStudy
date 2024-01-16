-- Check for null values across all columns
SELECT *
	FROM combined_data
	WHERE ride_id IS NULL OR 
	rideable_type IS NULL OR 
	started_at IS NULL OR 
	ended_at IS NULL OR	
	start_station_name IS NULL OR 
	start_station_id IS NULL OR 
	end_station_name IS NULL OR
	end_station_id IS NULL OR
	start_lat IS NULL OR 
	start_lng IS NULL OR
	end_lat IS NULL OR
	end_lng IS NULL OR
	member_casual IS NULL;
-- There are 25,90,952 rows which have a null value
-- All of these null values have to do with start station ID, start station name, end station name, and end station ID

--Checking for duplicate columns using ride id as ride id does not have null values
 Select COUNT(ride_id)- COUNT(distinct ride_id) AS duplicate_rows
 from combined_data
-- 16 duplicates were found


