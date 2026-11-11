# cancellation rate 

select
   (count(case when booking_status='Cancelled' then 1 end)*100.0)/count(*) AS Cancellation_Rate
   from factbooking;
   
#Total revenue 
select * from factbooking;
select sum(revenue_generated)as total  from factbooking;

#count of bookings 
select count(ï»¿booking_id) as tot  from factbooking;

#trend analysis
SELECT 
    DATE_FORMAT(STR_TO_DATE(booking_date, '%d-%m-%Y'), '%b') AS month,
    SUM(revenue_realized) AS total_value
FROM factbooking
GROUP BY MONTH(STR_TO_DATE(booking_date, '%d-%m-%Y')), month
ORDER BY MONTH(STR_TO_DATE(booking_date, '%d-%m-%Y'));

# weekday and weekend Revenue
SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(booking_date, '%d-%m-%Y')) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    SUM(revenue_realized) AS total_revenue
FROM factbooking
GROUP BY day_type;

#week day and weekend booking count 
SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(booking_date, '%d-%m-%Y')) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS booking_count
FROM factbooking
GROUP BY day_type;

select * from fact_aggregated_bookings;

#  Occupancy
SELECT 
CONCAT(ROUND(SUM(successful_bookings)*100 / SUM(capacity),2),'%') AS occupancy_rate
FROM fact_aggregated_bookings;

# Check Out  Cancelled  No Show 
SELECT 
SUM(CASE WHEN booking_status = 'Checked Out' THEN 1 ELSE 0 END) AS checkout,
SUM(CASE WHEN booking_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled,
SUM(CASE WHEN booking_status = 'No Show' THEN 1 ELSE 0 END) AS no_show
FROM factbooking;