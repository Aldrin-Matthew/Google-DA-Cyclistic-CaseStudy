# Google-DA-Cyclistic-CaseStudy:
[Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone)
## Introduction
In this case study, I will perform many real-world tasks of a junior data analyst at a fictional company, Cyclistic. In order to answer the key business questions, I will follow the steps of the data analysis process: Ask, Prepare, Process, Analyze, Share, and Act.
### Links
Data Source: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) 
  
SQL Queries:  
[01. Data Combining](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/blob/main/01.Data_Combining.sql)  
[02. Data Exploration](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/blob/main/02.Data_Exploration.sql)  
[03. Data Cleaning](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/blob/main/03.DataCleaning.sql)  
[04. Data Analysis](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/blob/main/04.Data_Analysis.R)  
  
## Background
### Cyclistic
A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day. 

Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.  
  
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno (the director of marketing and my manager) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.  

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.  

### Scenario
I am assuming to be assigned as a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve our recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## Ask
### Business Task
Devise marketing strategies to convert casual riders to members.
### Analysis Questions
Three questions will guide the future marketing program:  
1. How do annual members and casual riders use Cyclistic bikes differently?  
2. Why would casual riders buy Cyclistic annual memberships?  
3. How can Cyclistic use digital media to influence casual riders to become members?  

I have been assigned to answer the first question: How do annual members and casual riders use Cyclistic bikes differently?
## Prepare
### Data Source
I will use Cyclistic’s historical trip data to analyze and identify trends from Jan 2022 to Dec 2022 which can be downloaded from [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html). 
The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).  
  
This is public data that can be used to explore how different customer types are using Cyclistic bikes. But note that data-privacy issues prohibit from using riders’ personally identifiable information. This means that we won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.
### Data Organization
There are 12 files with naming convention of YYYYMM-divvy-tripdata and each file includes information for one month, such as the ride id, bike type, start time, end time, start station, end station, start location, end location, and whether the rider is a member or not. The corresponding column names are ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.

## Process
Microsoft SQL server management studio is used to combine the various datasets into one dataset and clean it.    
Reason:  
The Cyclistic dataset after combining would have more than 5 million rows.Hence, SQL server management studio is used because of the inability of Spreadsheets to handle this large of a dataset.
### Combining the Data
SQL Query: [Data Combining](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/blob/main/01.Data_Combining.sql)  
12 csv files are uploaded as tables in the dataset '2022_tripdata'. Another table named "combined_data" is created, containing 5,667,717 rows of data for the entire year. 
### Data Exploration
SQL Query: [Data Exploration](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/blob/main/02.Data_Exploration.sql)  
Before cleaning the data, I am familiarizing myself with the data to find the inconsistencies.  

Observations:  
1. The table below shows the . The __ride_id__ column is our primary key.  

 !!!!!!  ![image](https://user-images.githubusercontent.com/125132307/226139161-c5209861-7542-4ad6-8d9a-ce0115086e4d.png)  

2.  Note that some columns have same number of missing values. This may be due to missing information in the same row i.e. station's name and id for the same station and latitude and longitude for the same ending station.  
3. As ride_id has no null values, let's use it to check for duplicates.  

   ![image](https://user-images.githubusercontent.com/125132307/226181500-38f9b3ca-811d-4612-87ea-87b6d1d3843e.png)

   There are no __duplicate__ rows in the data.  
   
4. All __ride_id__ values have length of 16 so no need to clean it.
5. There are 3 unique types of bikes(__rideable_type__) in our data.

   ![image](https://user-images.githubusercontent.com/125132307/226203372-10c60802-0880-4b17-9ac0-2177ab862974.png)

6. The __started_at__ and __ended_at__ shows start and end time of the trip in YYYY-MM-DD hh:mm:ss UTC format. New column ride_length can be created to find the total trip duration. There are 5360 trips which has duration longer than a day and 122283 trips having less than a minute duration or having end time earlier than start time so need to remove them. Other columns day_of_week and month can also be helpful in analysis of trips at different times in a year.
7. Total of 833064 rows have both __start_station_name__ and __start_station_id__ missing which needs to be removed.  
8. Total of 892742 rows have both __end_station_name__ and __end_station_id__ missing which needs to be removed.
9. Total of 5858 rows have both __end_lat__ and __end_lng__ missing which needs to be removed.
10. __member_casual__ column has 2 uniqued values as member or casual rider.

    ![image](https://user-images.githubusercontent.com/125132307/226212522-aec43490-5d86-4e2e-a92e-b3bf52050415.png)

11. Columns that need to be removed are start_station_id and end_station_id as they do not add value to analysis of our current problem. Longitude and latitude location columns may not be used in analysis but can be used to visualise a map.
----------------------------------------------------------------------------
### Data Cleaning
SQL Query: [Data Cleaning](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/blob/main/03.DataCleaning.sql)  
1. All the rows having missing values are deleted.  
2. 3 more columns ride_length for duration of the trip, day_of_week and month are added.  
3. Trips with duration less than a minute and longer than a day are excluded.
4. Total 1,375,912 rows are removed in this step.
  
## Analyze and Share
SQL Query: [Data Analysis](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/blob/main/04.Data_Analysis.R)  
Data Visualization:Tableau  
The data is stored appropriately and is now prepared for analysis.  
The analysis question is: How do annual members and casual riders use Cyclistic bikes differently?  

First of all, member and casual riders are compared by the type of bikes they are using.  

![Percentage of member for each bike type](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/assets/156244140/712d0895-31f6-453d-9d4b-694d3c359698)

  
The members make 60% of the total while remaining 40% constitutes casual riders. Each bike type chart shows percentage from the total. Most used bike is classic bike followed by the electric bike. Docked bikes are used the least by only casual riders. 
  
Next the number of trips distributed by the months, days of the week and hours of the day are examined.  
![Total Rides per month](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/assets/156244140/b69277b6-bada-4d89-8bbf-089011036540)
![Total Rides per day of week](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/assets/156244140/d9e885cc-67bc-4021-9cfb-67fb4cf859a6)
![Total Rides per hour](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/assets/156244140/f22f6438-4cee-4cdf-bff3-8e5213ce199e)

__Months:__ Monthly trips taken for casual members and annual subscription members shows us that both exhibit similar behaviour wherein there are more trips in the spring and sumer and less trips during winters and beginning couple of months of they year.The gap between the two type of users is closest in the month of July. 

__Days of Week:__ Trips taken with respect to days of the week indicate that annual subscription members take more trips during the weekdays than in the weekends while the converse is true for casual members with a decline during weekdays and an increase during weekends.

__Hours of the Day:__ With respect to trips taken during hours of the day, annual subscription members show 2 peaks, one in the morning between 6am to 9 am and the other in the evening between 4pm to 6pm.
Casual riders however have a consistent upward slope until late evening and then a decline can be seen after that.

We can infer from the previous observations especially the ride timings that annual subscription members may be using the bikes for commuting to and fro from work while the casual riders use the bikes in a more leisurely manner especially during the weekends.
  
Lets look at ride duration to further analyse the behavioural difference between casual and annual subscription members  
![Average Ride Length by Month](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/assets/156244140/606aa7e7-c49f-44e4-87ef-85d756d83468)
![Average Ride Length by Day of Week](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/assets/156244140/39610b97-5de5-485d-8c60-328114ef3109)
![Average Ride Length by Hour](https://github.com/Aldrin-Matthew/Google-DA-Cyclistic-CaseStudy/assets/156244140/9504779d-24a2-4822-bd1b-0f4f7d1211c4)
  
In each of the graphs it can be seen that casual members cycle longer almost 2x more than members do on average albeit less frequently.
The average length of the journey for members does not fluctuate as much as the average length of the casual riders.In the case of casual riders, there are variations during spring and summer and during the late morning and early afternoon period where they travel longer distances.Between five and eight in the morning, they have brief trips.These findings further strengthen the fact that casual commuters make longer journeys on weekends and outside of work-home commuting hours, possibly for recreational purposes.
  
To further understand the differences in casual and member riders, locations of starting and ending stations can be analysed. Stations with the most trips are considered using filters to draw out the following conclusions.  
  
![image](https://user-images.githubusercontent.com/125132307/230248445-3fe69cbb-30a9-42c6-b5e8-ab433a620ff3.png)  
  
Casual riders have frequently started their trips from the stations in vicinity of museums, parks, beach, harbor points and aquarium while members have begun their journeys from stations close to universities, residential areas, restaurants, hospitals, grocery stores, theatre, schools, banks, factories, train stations, parks and plazas.  
  
![image](https://user-images.githubusercontent.com/125132307/230253219-4fb8a2ed-95e3-4e52-a359-9d86945b7a75.png)
  
We can onserve a similar trend in the ending stations. Casual riders end their journey near parks, museums and other recreational sites whereas members end their trips close to universities, residential and commmercial areas. So this proves that casual riders use bikes for leisure activities while members extensively rely on them for daily commute.  
  
Summary:
  
|Member|Casual|
|------|------|
|Mostly prefer riding bikes on weekdays especially during office commute hours in summer and spring.|Prefer using bikes more frequently over the weekends in summer and spring for leisure activities.|
|Travel more frequently but the duration of the ride is short.|Travel more than double the time but less frequently than members.|
|Their start and end stations are mostly near residential, commericial and university areas.|Start and end their journeys near parks, museums, along the coast and other recreational sites.|  
  
## Act
After identifying the differences between casual and member riders, marketing strategies to target casual riders can be developed to persuade them to become members.  
Recommendations:  
1. Marketing campaigns might be conducted in spring and summer at tourist/recreational locations popular among casual riders.
2. Casual riders are most active on weekends and during the summer and spring, thus they may be offered seasonal or weekend-only memberships.
3. Casual riders use their bikes for longer durations than members. Offering discounts for longer rides may incentivize casual riders and entice members to ride for longer periods of time.
