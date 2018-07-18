/*
Question #1 Queries
*/

SELECT COUNT(DISTINCT utm_campaign) as 'Campaign_Total'
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) as 'Source_Total'
FROM page_visits;

SELECT DISTINCT utm_campaign as 'Distinct_Campaign', 
		utm_source as 'Source'
FROM page_visits;

/*
Question #2 Queries
*/

SELECT DISTINCT page_name as 'Distinct_Pages'
FROM page_visits;

/*
Question #3 Queries
*/

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source as 'Source',
       ft_attr.utm_campaign as 'Campaign',
       COUNT(*) as 'Total'
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

/*
Question #4 Queries
*/

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source as 'Source',
       lt_attr.utm_campaign as 'Campaign',
       COUNT(*) as 'Total'
FROM lt_attr
GROUP BY 2
ORDER BY 3 DESC;

/*
Question #5 Queries
*/

SELECT page_name as 'Site_Page',
	count(distinct user_id) as 'Total_Users'
FROM page_visits
GROUP BY 1;

/*
Question #6 Queries
*/

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    WHERE page_name = '4 - purchase'
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source as 'Source',
       lt_attr.utm_campaign as 'Campaign',
       COUNT(*) as 'Total_P'
FROM lt_attr
GROUP BY 2
ORDER BY 3 DESC;

/*
Question #7 Queries
*/
