
Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).


# SQL Code. 
step 1:
# 
weather['recordDate'] = pd.to_datetime(weather['recordDate'])

# create a copy of the weather DataFrame with a 1 day shift. 
import pandas as pd

def rising_temperature(weather: pd.DataFrame) -> pd.DataFrame:
    # Ensure the 'recordDate' column is a datetime type
    weather['recordDate'] = pd.to_datetime(weather['recordDate'])
    
    # Sorting the DataFrame by 'recordDate' to ensure the shift operation works correctly
    weather.sort_values('recordDate', inplace=True)
    
    # Creating new columns for the previous day's temperature and record date
    weather['PreviousTemperature'] = weather['temperature'].shift(1)
    weather['PreviousRecordDate'] = weather['recordDate'].shift(1)
    
    # Filtering the DataFrame to find rows where the temperature is higher 
    # than the previous day and the date is exactly one day more than the previous record date
    result = weather[
        (weather['temperature'] > weather['PreviousTemperature']) & 
        (weather['recordDate'] == weather['PreviousRecordDate'] + pd.Timedelta(days=1))
    ][['id']].rename(columns={'id': 'Id'})
    
    return result

# SQL Code.
# Write your MySQL query statement below
SELECT 
    w1.id
FROM
    Weather w1
JOIN 
    Weather w2
ON
    DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE
    w1.temperature > w2.temperature;