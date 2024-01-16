
-- Create an empty combined_data table with the desired structure
CREATE TABLE combined_data(
  -- Specify columns with appropriate data types
	  ride_id nvarchar(255),
	  rideable_type nvarchar(255),
	  started_at  datetime,
	  ended_at datetime,
	  start_station_name nvarchar(255),
	  start_station_id nvarchar(255),
	  end_station_name nvarchar(255),
	  end_stationid nvarchar(255),
	  start_lat	float,
	  start_lng float,
	  end_lat float,
	  end_lng float,
	  member_casual nvarchar(255)

);
-- Insert data into the combined_data table
INSERT INTO combined_data
	SELECT * FROM "202201_tripdata"
	UNION ALL
	SELECT * FROM "202202_tripdata"
	UNION ALL
	SELECT * FROM "202203_tripdata"
	UNION ALL
	SELECT * FROM "202204_tripdata"
	UNION ALL
	SELECT * FROM "202205_tripdata"
	UNION ALL
	SELECT * FROM "202206_tripdata"
	UNION ALL
	SELECT * FROM "202207_tripdata"
	UNION ALL
	SELECT * FROM "202208_tripdata"
	UNION ALL
	SELECT * FROM "202209_tripdata"
	UNION ALL
	SELECT * FROM "202210_tripdata"
	UNION ALL
	SELECT * FROM "202211_tripdata"
	UNION ALL
	SELECT * FROM "202212_tripdata";

---Check number of rows 