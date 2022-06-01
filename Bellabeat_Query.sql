--Find the number of distinct user
SELECT COUNT(DISTINCT Id) as Number_of_User
FROM `bellabeatcasestudy-351503.FitabaseData.DailyActivity`;

--Statistics on Daily Activities
SELECT 
ROUND(AVG(TotalSteps),2) as Average_step_per_day,
ROUND(AVG(TotalDistance),2) as Average_total_distance,
ROUND(AVG(TrackerDistance),2) as Average_tracker_distance,
ROUND(AVG(Calories),2) as Average_calories
FROM `bellabeatcasestudy-351503.FitabaseData.DailyActivity`;

--Statistics on Daily Activities for each day
SELECT
ActivityDate, 
ROUND(AVG(TotalSteps),2) as Average_step_per_day,
ROUND(AVG(TotalDistance),2) as Average_total_distance,
ROUND(AVG(TrackerDistance),2) as Average_tracker_distance,
ROUND(AVG(Calories),2) as Average_calories,
COUNT(DISTINCT Id) as Number_of_user
FROM `bellabeatcasestudy-351503.FitabaseData.DailyActivity`
GROUP BY ActivityDate;


--Statistics on Daily Activities for each user
SELECT
Id, 
ROUND(AVG(TotalSteps),2) as Average_step_per_day,
ROUND(AVG(TotalDistance),2) as Average_total_distance,
ROUND(AVG(TrackerDistance),2) as Average_tracker_distance,
ROUND(AVG(Calories),2) as Average_calories,
COUNT(DISTINCT ActivityDate) as Number_of_Record
FROM `bellabeatcasestudy-351503.FitabaseData.DailyActivity`
GROUP BY Id;

--Statistics on Daily Activities for each Day of week
SELECT 
FORMAT_TIMESTAMP("%A", ActivityDate) as Day_of_week,
ROUND(AVG(TotalSteps),2) as Average_step_per_day,
ROUND(AVG(TotalDistance),2) as Average_total_distance,
ROUND(AVG(TrackerDistance),2) as Average_tracker_distance,
ROUND(AVG(Calories),2) as Average_calories,
COUNT(ActivityDate) as Number_of_Record
FROM `bellabeatcasestudy-351503.FitabaseData.DailyActivity`
GROUP BY Day_of_week
ORDER BY 
CASE Day_of_week
  WHEN 'Monday' THEN 1
  WHEN 'Tuesday' THEN 2
  WHEN 'Wednesday' THEN 3
  WHEN 'Thursday' THEN 4 
  WHEN 'Friday' THEN 5 
  WHEN 'Saturday' THEN 6
  WHEN 'Sunday' Then 7
END;

--Statistics on Active Minutes
WITH total as(
SELECT 
SUM(VeryActiveMinutes) as Total_very_active_min,
SUM(FairlyActiveMinutes) as Total_fairly_active_min,
SUM(LightlyActiveMinutes) as Total_lightly_active_min,
SUM(SedentaryMinutes) as Total_Sedentary_min,
SUM(VeryActiveMinutes)+SUM(FairlyActiveMinutes)+SUM(LightlyActiveMinutes)+SUM(SedentaryMinutes) as Total_Minute
FROM `bellabeatcasestudy-351503.FitabaseData.DailyActivity`)
SELECT 
Total_very_active_min,
CONCAT(ROUND(Total_very_active_min/Total_Minute*100,2),'%') as Percentage_of_very_active_min,
Total_fairly_active_min,
CONCAT(ROUND(Total_fairly_active_min/Total_Minute*100,2),'%') as Percentage_of_fairly_active_min,
Total_lightly_active_min,
CONCAT(ROUND(Total_lightly_active_min/Total_Minute*100,2),'%') as Percentage_of_lightly_active_min,
Total_Sedentary_min,
CONCAT(ROUND(Total_Sedentary_min/Total_Minute*100,2),'%') as Percentage_of_Sedentary_min
FROM total;

--Total Number of steps in different hours of a day
SELECT 
FORMAT_TIMESTAMP("%l %p",ActivityHour) as HOUR,
SUM(StepTotal)
FROM `bellabeatcasestudy-351503.FitabaseData.hourlySteps`
GROUP BY HOUR
ORDER BY 2 DESC;

SELECT COUNT(Id)
FROM `bellabeatcasestudy-351503.FitabaseData.hourlyIntensities`
Where TotalIntensity !=0 or TotalIntensity !=0;

--Find relation bewteen daily activities and sleep time

SELECT s.*,d.ActivityDate,d.TotalSteps,d.TotalDistance,d.SedentaryMinutes,d.VeryActiveMinutes,d.FairlyActiveMinutes,d.LightlyActiveMinutes,d.Calories
FROM `bellabeatcasestudy-351503.FitabaseData.DailyActivity` d
INNER JOIN `bellabeatcasestudy-351503.FitabaseData.sleepDay` s
ON (d.Id = s.Id and d.ActivityDate = s.SleepDay);










