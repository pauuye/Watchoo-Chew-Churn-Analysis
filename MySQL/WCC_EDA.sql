-- Watchoo Chew, Inc.
-- Customer Churn  Analysis

SELECT 
	*
FROM netflix;

WITH dupli AS (
	SELECT 
		*, 
        ROW_NUMBER() OVER(PARTITION BY customer_id, 
		age, gender, subscription_type, watch_hours, last_login_days, 
        region, device, monthly_fee, churned, payment_method, number_of_profiles, 
        avg_watch_time_per_day, favorite_genre) as count_row
	FROM netflix)
SELECT *
FROM dupli
WHERE count_row > 1;

-- customer id length count
SELECT 
	length(customer_id)
FROM netflix
where length(customer_id) > 36;

-- Total customer distribution by gender
SELECT
	gender,
    total_count,
	CONCAT(ROUND(total_count/SUM(total_count) OVER() * 100, 2), '%') AS percentage
FROM (
	SELECT 
		gender, 
		COUNT(customer_id) as total_count
	FROM netflix
	GROUP BY gender
) t
ORDER BY percentage DESC; 
-- end --

-- DISTINCT column*
SELECT 
	DISTINCT age
FROM netflix
ORDER BY 1;
-- END --

-- Age bracketing 
-- Young Adult 18–29 
-- Adult 30–44 
-- Middle Age 45–59 
-- Senior 60–70

-- Churned Percetange by Age Bracket
-- Why Middle Age is the highest? Less time to use the service?
WITH age_bracket AS (
	SELECT 
		CASE 
			WHEN age BETWEEN 18 and 29 THEN "Young Adult (18-29)"
			WHEN age BETWEEN 30 and 44 THEN "Adult (30-44)"
			WHEN age BETWEEN 45 and 59 THEN "Middle Age (45-59)"
			WHEN age >= 60 THEN "Senior (60+)"
		END as Bracket,
        COUNT(*) as total_user,
		SUM(churned) as total_churned
	FROM netflix
    GROUP BY Bracket
)
SELECT 
	Bracket, 
	total_user,
	total_churned,
	CONCAT(ROUND(total_user/SUM(total_churned) OVER() *100, 2), "%") as churn_rate,
    CONCAT(ROUND(total_churned/SUM(total_churned) OVER() *100, 2), "%") as churn_share
FROM age_bracket
ORDER BY churn_share DESC;


-- Average watching hours by Age Bracket
-- Middle Age (45-59), are not the age braket with the lowest average of watchtime but, less average watching hours does affect the churn of a user.
-- Improve service, introduce loyalty promotion.
WITH age_bracket AS (
	SELECT 
		CASE 
			WHEN age BETWEEN 18 and 29 THEN "Young Adult (18-29)"
			WHEN age BETWEEN 30 and 44 THEN "Adult (30-44)"
			WHEN age BETWEEN 45 and 59 THEN "Middle Age (45-59)"
			WHEN age >= 60 THEN "Senior (60+)"
		END as Bracket,
        ROUND(AVG(watch_hours), 2) as avg_watch_H,
        COUNT(*) as total_user,
        SUM(churned) as TotalChurned
	FROM netflix
    GROUP BY Bracket
)
SELECT 
	Bracket, 
	avg_watch_H,
    total_user,
    CONCAT(ROUND(TotalChurned/total_user*100, 2), '%') as churn_rate,
    CONCAT(ROUND(TotalChurned/SUM(TotalChurned) OVER()* 100, 2), '%') as churn_share
FROM age_bracket
GROUP BY Bracket
ORDER BY churn_share DESC;

-- Does spending affects the churn?
-- Average Monthly fee by Age bracket
WITH age_bracket AS (
	SELECT 
		CASE 
			WHEN age BETWEEN 18 and 29 THEN "Young Adult (18-29)"
			WHEN age BETWEEN 30 and 44 THEN "Adult (30-44)"
			WHEN age BETWEEN 45 and 59 THEN "Middle Age (45-59)"
			WHEN age >= 60 THEN "Senior (60+)"
		END as Bracket,
        CONCAT("$", ROUND(AVG(monthly_fee), 2)) as avg_monthly,
        SUM(churned) as TotalChurned
	FROM netflix
	GROUP BY Bracket
)
SELECT 
	Bracket, 
	avg_monthly,
    CONCAT(ROUND(TotalChurned/SUM(TotalChurned) OVER()* 100, 2), '%') as ChurnedPercentage
FROM age_bracket
ORDER BY ChurnedPercentage DESC;

-- Most availed subscription type
-- Basic subscription have the highest churn rate and share
-- Introduce a loyalty promo and improve customer service
SELECT 
	subscription_type,
    churn,
    total_user,
    CONCAT(ROUND(total_user/SUM(total_user) OVER() * 100, 2), '%') as user_share,
	CONCAT(ROUND(churn/total_user * 100, 2), '%') as churn_rate,
    CONCAT(ROUND(churn/SUM(churn) OVER() * 100, 2), '%') as churn_share
FROM (
SELECT 
    subscription_type, 
    COUNT(subscription_type) as total_user,
    SUM(churned) as churn
FROM netflix
GROUP BY subscription_type
) t
ORDER BY churn DESC;
-- 

-- Subscription type by Age Bracket
WITH age_bracket AS (
	SELECT
		CASE 
			WHEN age BETWEEN 18 and 29 THEN "Young Adult (18-29)"
			WHEN age BETWEEN 30 and 44 THEN "Adult (30-44)"
			WHEN age BETWEEN 45 and 59 THEN "Middle Age (45-59)"
			WHEN age >= 60 THEN "Senior (60+)"
		END as Bracket,
        SUM(subscription_type = "Basic") as Basic,
		SUM(subscription_type = "Standard") as Standard,
		SUM(subscription_type = "Premium") as Premium
	FROM netflix
    GROUP BY Bracket
)
SELECT 
	Bracket,
    Basic,
    Standard,
    Premium,
    CASE GREATEST(Basic, Standard, Premium)
		WHEN Basic THEN 'Basic'
        WHEN Standard THEN 'Standard'
        WHEN Premium THEN 'Premium'
    END Top_Availed
FROM age_bracket;
-- end --

-- What device each age bracket uses the most
WITH age_bracket AS (
	SELECT
		CASE  
			WHEN age BETWEEN 18 and 29 THEN "Young Adult (18-29)"
			WHEN age BETWEEN 30 and 44 THEN "Adult (30-44)"
			WHEN age BETWEEN 45 and 59 THEN "Middle Age (45-59)"
			WHEN age >= 60 THEN "Senior (60+)"
		END as Bracket,
        SUM(device = "TV") as TV,
		SUM(device = "Mobile") as Mobile,
		SUM(device = "Laptop") as Laptop,
        SUM(device = "Desktop") as Desktop,
        SUM(device = "Tablet") as Tablet
	FROM netflix
    GROUP BY Bracket
),
totals AS (
	  SELECT
			Bracket,
			TV,
			Mobile,
			Laptop,
			Desktop,
			Tablet,
			(TV + Mobile + Laptop + Desktop + Tablet) AS Total
	  FROM age_bracket
)
SELECT 
	Bracket,
	CONCAT(ROUND(TV * 100.0 / Total, 2), "%") AS TV_percent,
	CONCAT(ROUND(Mobile * 100.0 / Total, 2), "%") AS Mobile_percent,
	CONCAT(ROUND(Laptop * 100.0 / Total, 2), "%") AS Laptop_percent,
	CONCAT(ROUND(Desktop * 100.0 / Total, 2), "%") AS Desktop_percent,
	CONCAT(ROUND(Tablet * 100.0 / Total, 2), "%") AS Tablet_percent,
    CASE GREATEST(TV, Mobile, Laptop, Desktop, Tablet)
		WHEN TV THEN 'TV'
		WHEN Mobile THEN 'Mobile'
        WHEN Laptop THEN 'Laptop'
        WHEN Desktop THEN 'Desktop'
        WHEN Tablet THEN 'Tablet'
    END Most_Used
FROM totals;
-- END --

-- which device the customer uses the most and have the highest churned
WITH base AS (
	SELECT 
		device,
		COUNT(*) AS Most_Used,
		SUM(churned) as total_churned
	FROM netflix
	GROUP BY device
),
churned AS(
	SELECT
		device,
        Most_Used,
        total_churned,
        CONCAT(ROUND(total_churned/Most_Used*100, 2), "%") as churned_percent
	FROM base
)
SELECT 
	Device,
    Most_Used,
    total_churned,
    churned_percent
FROM churned
ORDER BY churned_percent DESC;
-- end --

-- Region
-- Total Customer and Churned by Region
WITH c_percent AS (
	SELECT 
		region, 
		COUNT(customer_id) as customer_count,
		SUM(Churned) as total_churned
	FROM netflix
	GROUP BY region
)
SELECT 
	region,
    customer_count,
    total_churned,
	CONCAT(ROUND(total_churned/customer_count*100, 2), "%") as Churned_Percent
FROM c_percent
ORDER BY Churned_Percent DESC;

-- Monthly Revenue by region and churn rate
WITH c_percent AS (
	SELECT 
		region, 
		COUNT(customer_id) as customer_count,
		SUM(Churned) as total_churned,
        CONCAT("$",ROUND(SUM(monthly_fee),2)) as total_monthly_sum
	FROM netflix
	GROUP BY region
)
SELECT 
	region,
    total_monthly_sum,
	CONCAT(ROUND(total_churned/customer_count*100, 2), "%") as Churned_Percent
FROM c_percent
ORDER BY Churned_Percent DESC;


-- Most payment method used
-- Churned rate by Payment Method
WITH payment AS(
	SELECT 
		payment_method,
		COUNT(*) AS Total_Users,
		SUM(churned) as Total_Churned
	FROM
		netflix
	GROUP BY payment_method
)
SELECT
	payment_method,
    Total_Users,
    Total_Churned,
    CONCAT(ROUND(Total_Churned/Total_Users*100, 2), "%") as Percent
FROM payment
ORDER BY Percent DESC;


-- Most used Payment Method by Age Bracket
WITH age_bracket AS (
	SELECT 
		age,
        payment_method,
		CASE 
			WHEN age BETWEEN 18 and 29 THEN "Young Adult (18-29)"
			WHEN age BETWEEN 30 and 44 THEN "Adult (30-44)"
			WHEN age BETWEEN 45 and 59 THEN "Middle Age (45-59)"
			WHEN age >= 60 THEN "Senior (60+)"
		END as Bracket
	FROM netflix),
payment AS (
	SELECT
		Bracket,
		SUM(payment_method = 'Crypto') as Crypto,
		SUM(payment_method = 'Gift Card') as Gift_Card,
        SUM(payment_method = 'Paypal') as Paypal,
        SUM(payment_method = 'Debit Card') as Debit_Card,
        SUM(payment_method = 'Credit Card') as Credit_Card
	FROM age_bracket
	GROUP BY Bracket
	ORDER BY 2 DESC)
SELECT 
	Bracket,
	Crypto,
	Gift_Card,
	Paypal,
	Debit_Card,
	Credit_Card,
	CASE GREATEST (Crypto, Gift_Card, Paypal, Debit_Card, Credit_Card)
		WHEN Crypto THEN 'Crypto'
		WHEN Gift_Card THEN 'Gift Card'
		WHEN Paypal THEN 'Paypal'
		WHEN Debit_Card THEN 'Debit Card'
		WHEN Credit_Card THEN 'Credit Card'
	END MostUsed_PaymentMethod
FROM payment;
-- end --










