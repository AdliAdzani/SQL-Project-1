/*
Data Profiling & Analyzing of Yelp Dataset

SKills used: Checking Null Values, Mathematical Function, Grouping and Sorting Data, Correlation of the Dataset, JOINS function, Aggregate Function */

-- Data Cleaning for the USers Table, by checking whether there is Null values or not.

	SELECT * FROM User
	  WHERE (id IS NULL 
		OR name IS NULL
		OR review_count IS NULL
		OR yelping_since IS NULL
		OR useful IS NULL
		OR funny IS NULL
		OR cool IS NULL
		OR fans IS NULL
		OR average_stars IS NULL
		OR compliment_hot IS NULL
		OR compliment_more IS NULL
		OR compliment_profile IS NULL
		OR compliment_cute IS NULL
		OR compliment_list IS NULL
		OR compliment_note IS NULL
		OR compliment_plain IS NULL
		OR compliment_cool IS NULL
		OR compliment_funny IS NULL
		OR compliment_writer IS NULL
		OR compliment_photos IS NULL);
    
-- Finding the top cities with most reviews.

	SELECT City, SUM(review_count) AS Total_reviews
	FROM Business
	GROUP BY City
	ORDER BY Total_reviews DESC;

	+-----------------+---------------+
	| city            | Total_reviews |
	+-----------------+---------------+
	| Las Vegas       |         82854 |
	| Phoenix         |         34503 |
	| Toronto         |         24113 |
	| Scottsdale      |         20614 |
	| Charlotte       |         12523 |
	| Henderson       |         10871 |
	| Tempe           |         10504 |
	| Pittsburgh      |          9798 |
	| Montréal        |          9448 |
	| Chandler        |          8112 |
	| Mesa            |          6875 |
	| Gilbert         |          6380 |
	| Cleveland       |          5593 |
	| Madison         |          5265 |
	| Glendale        |          4406 |
	| Mississauga     |          3814 |
	| Edinburgh       |          2792 |
	| Peoria          |          2624 |
	| North Las Vegas |          2438 |
	| Markham         |          2352 |
	| Champaign       |          2029 |
	| Stuttgart       |          1849 |
	| Surprise        |          1520 |
	| Lakewood        |          1465 |
	| Goodyear        |          1155 |
	+-----------------+---------------+
	(Output limit exceeded, 25 of 362 total rows shown)
    
-- Find the distribution of star ratings for both Avon & Beachwood cities;

	-- City: Avon
	SELECT Stars, SUM (review_count) 
	FROM Business
	WHERE City = 'Avon'
	GROUP BY Stars; 
  
	+-------+--------------------+
	| stars | SUM (review_count) |
	+-------+--------------------+
	|   1.5 |                 10 |
	|   2.5 |                  6 |
	|   3.5 |                 88 |
	|   4.0 |                 21 |
	|   4.5 |                 31 |
	|   5.0 |                  3 |
	+-------+--------------------+

	-- City: Beachwood
	SELECT Stars, SUM (review_count) AS Star_ratings_count
	FROM Business
	WHERE City = 'Beachwood'
	GROUP BY Stars;
  
	+-------+--------------------+
	| stars | Star_ratings_count |
	+-------+--------------------+
	|   2.0 |                  8 |
	|   2.5 |                  3 |
	|   3.0 |                 11 |
	|   3.5 |                  6 |
	|   4.0 |                 69 |
	|   4.5 |                 17 |
	|   5.0 |                 23 |
	+-------+--------------------+
  
-- Finding the top 3 users based on their total number of views;

	SELECT Name, SUM(review_count) AS Total_reviews
	FROM User
	GROUP BY id
	ORDER BY Total_reviews DESC
	LIMIT 3;

	+--------+---------------+
	| name   | Total_reviews |
	+--------+---------------+
	| Gerald |          2000 |
	| Sara   |          1629 |
	| Yuri   |          1339 |
	+--------+---------------+
  
-- Check whether having more reviews are positively correlate with having more fans.

	SELECT Name, SUM (review_count) AS Total_reviews, Fans
	FROM User
	GROUP BY id
	ORDER BY Total_reviews DESC;

	+-----------+---------------+------+
	| name      | Total_reviews | fans |
	+-----------+---------------+------+
	| Gerald    |          2000 |  253 |
	| Sara      |          1629 |   50 |
	| Yuri      |          1339 |   76 |
	| .Hon      |          1246 |  101 |
	| William   |          1215 |  126 |
	| Harald    |          1153 |  311 |
	| eric      |          1116 |   16 |
	| Roanna    |          1039 |  104 |
	| Mimi      |           968 |  497 |
	| Christine |           930 |  173 |
	| Ed        |           904 |   38 |
	| Nicole    |           864 |   43 |
	| Fran      |           862 |  124 |
	| Mark      |           861 |  115 |
	| Christina |           842 |   85 |
	| Dominic   |           836 |   37 |
	| Lissa     |           834 |  120 |
	| Lisa      |           813 |  159 |
	| Alison    |           775 |   61 |
	| Sui       |           754 |   78 |
	| Tim       |           702 |   35 |
	| L         |           696 |   10 |
	| Angela    |           694 |  101 |
	| Crissy    |           676 |   25 |
	| Lyn       |           675 |   45 |
	+-----------+---------------+------+
	(Output limit exceeded, 25 of 10000 total rows shown)
	
-- Find the total number of reviews that have word "love" or 'hate" in them.

	SELECT Feelings, COUNT(Feelings) AS Total_count
	FROM (SELECT CASE
	WHEN Text LIKE '%love%' THEN 'Love'
	WHEN Text LIKE '%hate%' THEN 'Hate'
	ELSE 'Others'
	END AS Feelings
	FROM Review)
	GROUP BY Feelings
	ORDER BY Total_count DESC;

	+----------+-------------+
	| Feelings | Total_count |
	+----------+-------------+
	| Others   |        8042 |
	| Love     |        1780 |
	| Hate     |         178 |
	+----------+-------------+
  
-- Find the top 10 users with most fans.

	SELECT Name, SUM(Fans) AS Total_fans
	FROM User
	GROUP BY id
	ORDER BY Total_fans DESC
	LIMIT 10;

	+-----------+------------+
	| name      | Total_fans |
	+-----------+------------+
	| Amy       |        503 |
	| Mimi      |        497 |
	| Harald    |        311 |
	| Gerald    |        253 |
	| Christine |        173 |
	| Lisa      |        159 |
	| Cat       |        133 |
	| William   |        126 |
	| Fran      |        124 |
	| Lissa     |        120 |
	+-----------+------------+
  
-- Choose 1 City & 1 Category, group them with the overall star ratings score. Compare the difference in the number of views of those groups.

	-- In this case, I choose Toronto as City & Restaurants as Category
  
	SELECT CASE
		WHEN b.Stars BETWEEN 4 AND 5 THEN '4-5 Stars'
		WHEN b.Stars BETWEEN 2 AND 3 THEN '2-3 Stars'
		ELSE 'Below 2 Stars'
		END AS Star_ratings,
	b.City, c.Category, SUM(b.review_count) AS Total_review
	FROM Business b
	INNER JOIN Category c ON b.id = c.business_id
	WHERE b.City = 'Toronto' AND c.Category = 'Restaurants'
	GROUP BY Star_ratings;

	+---------------+---------+-------------+--------------+
	| Star_ratings  | city    | category    | Total_review |
	+---------------+---------+-------------+--------------+
	| 2-3 Stars     | Toronto | Restaurants |           86 |
	| 4-5 Stars     | Toronto | Restaurants |          206 |
	| Below 2 Stars | Toronto | Restaurants |            7 |
	+---------------+---------+-------------+--------------+

-- Group the businesses with the ones that are open & ones that are closed, compared the average stars received & the number of reviews for those group.

	SELECT CASE 
	WHEN Is_open = 1 THEN 'Open'
	WHEN Is_open = 0 THEN 'Closed'
	END 'Store_status',
	COUNT(DISTINCT id) AS Total_stores, SUM(Review_count) AS Total_reviews, ROUND(AVG(Stars),2) AS Average_stars
	FROM Business
	GROUP BY Store_status;

	+--------------+--------------+---------------+---------------+
	| Store_status | Total_stores | Total_reviews | Average_stars |
	+--------------+--------------+---------------+---------------+
	| Closed       |         1520 |         35261 |          3.52 |
	| Open         |         8480 |        269300 |          3.68 |
	+--------------+--------------+---------------+---------------+

-- Analyze what are the commonalities of the most successful business based on the stars rating.

	--I'll be limiting the data by only showing those businesses have stars above 3.5 & number of store more than 10

	SELECT c.Category, COUNT(DISTINCT b.id) AS Total_stores, 
		SUM(b.review_count) AS Total_reviews, 
		ROUND(AVG(b.stars),2) AS Average_stars
	FROM Business b
	INNER JOIN Category c ON b.id = c.business_id
	GROUP BY c.Category
	HAVING Total_stores >= 10 AND Average_stars >= 3.5
	ORDER BY Average_stars DESC

	+------------------------+--------------+---------------+---------------+
	| category               | Total_stores | Total_reviews | Average_stars |
	+------------------------+--------------+---------------+---------------+
	| Local Services         |           12 |           100 |          4.21 |
	| Active Life            |           10 |           131 |          4.15 |
	| Health & Medical       |           17 |           203 |          4.09 |
	| Home Services          |           16 |            94 |           4.0 |
	| Shopping               |           30 |           977 |          3.98 |
	| Beauty & Spas          |           13 |           119 |          3.88 |
	| American (Traditional) |           11 |          1128 |          3.82 |
	| Food                   |           23 |          1781 |          3.78 |
	| Bars                   |           17 |          1322 |           3.5 |
	+------------------------+--------------+---------------+---------------+
