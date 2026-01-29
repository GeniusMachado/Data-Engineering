


1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates

MariaDB [sakila]> select COUNT(DISTINCT(email)), COUNT(*) from sakila.customer;
+------------------------+----------+
| COUNT(DISTINCT(email)) | COUNT(*) |
+------------------------+----------+
|                    599 |      599 |
+------------------------+----------+
Since we can see that count of all the rows matches with the count of all distinct emails, we can thereby confirm that there are no duplicates wihtout using the customer_id or we can also use goupby and having clause simultaneously with first name, last name and email. 
MariaDB [sakila]> SELECT first_name, last_name, email, COUNT(*) as occurrence_count FROM customer GROUP BY first_name, last_name, email HAVING COUNT(*) > 1;
Empty set (0.009 sec)









2. Number of times letter 'a' is repeated in film descriptions
MariaDB [sakila]> SELECT description,(LENGTH(description) - LENGTH(REPLACE(description, 'a', ''))) AS count_of_a FROM film limit 5;
+-----------------------------------------------------------------------------------------------------------------------+------------+
| description                                                                                                           | count_of_a |
+-----------------------------------------------------------------------------------------------------------------------+------------+
| A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies                      |         11 |
| A Astounding Epistle of a Database Administrator And a Explorer who must Find a Car in Ancient China                  |          9 |
| A Astounding Reflection of a Lumberjack And a Car who must Sink a Lumberjack in A Baloon Factory                      |          8 |
| A Fanciful Documentary of a Frisbee And a Lumberjack who must Chase a Monkey in A Shark Tank                          |          9 |
| A Fast-Paced Documentary of a Pastry Chef And a Dentist who must Pursue a Forensic Psychologist in The Gulf of Mexico |          7 |
+-----------------------------------------------------------------------------------------------------------------------+------------+
So here I am first calculating the length of the entire description column and then subtracting it by the substring of the description column but replacing all the 'a' with null character. So that way we know the difference in the two strings with and without occurence of 'a'. 
In order to get the total number of occurence of 'a' in the entire table descriptions we can use SUM functionin the following way:
MariaDB [sakila]> SELECT SUM(LENGTH(description) - LENGTH(REPLACE(description, 'a', ''))) AS total_a_count
    -> FROM film;
+---------------+
| total_a_count |
+---------------+
|          8263 |
+---------------+
1 row in set (0.008 sec)

I also thought of a better way of doing this by concatinating the entire description column into one string and then breaking into into multiple substrings whenever we encounter 'a' and then renturning the count of those susbtrings but when I looked up online then introduced me to recursive concepts and also hard problems like UNION and then the query became too big. Also, I encoutnered the limitations of GROUP_COUNT() function while trying this.  








3. Number of times each vowel is repeated in film descriptions 
My approach will be to have 5 columns for each individual vowel to show its count. Also, will have to be mindful of using the string LOWER() function to consider any capital alphabets of vowels too.
MariaDB [sakila]> SELECT 
    ->     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'a', ''))) AS count_a,
    ->     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'e', ''))) AS count_e,
    ->     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'i', ''))) AS count_i,
    ->     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'o', ''))) AS count_o,
    ->     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'u', ''))) AS count_u
    -> FROM film;
+---------+---------+---------+---------+---------+
| count_a | count_e | count_i | count_o | count_u |
+---------+---------+---------+---------+---------+
|   11492 |    5944 |    4938 |    5915 |    3191 |
+---------+---------+---------+---------+---------+


if I had to make it more informative than I would use group by description to show the individual description values as well using an obvious LIMIT clause:

MariaDB [sakila]> SELECT     description, SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'a', ''))) AS count_a,     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'e', ''))) AS count_e,     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'i', ''))) AS count_i,     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'o', ''))) AS count_o,     SUM(LENGTH(description) - LENGTH(REPLACE(LOWER(description), 'u', ''))) AS count_u FROM film group by description limit 20;
+--------------------------------------------------------------------------------------------------------------------------+---------+---------+---------+---------+---------+
| description                                                                                                              | count_a | count_e | count_i | count_o | count_u |
+--------------------------------------------------------------------------------------------------------------------------+---------+---------+---------+---------+---------+
| A Action-Packed Character Study of a Astronaut And a Explorer who must Reach a Monkey in A MySQL Convention              |      13 |       7 |       3 |       8 |       3 |
| A Action-Packed Character Study of a Dog And a Lumberjack who must Outrace a Moose in The Gulf of Mexico                 |      11 |       7 |       3 |       9 |       5 |
| A Action-Packed Character Study of a Forensic Psychologist And a Girl who must Build a Dentist in The Outback            |      10 |       5 |       7 |       7 |       4 |
| A Action-Packed Display of a Feminist And a Pioneer who must Pursue a Dog in A Baloon Factory                            |      11 |       5 |       6 |       8 |       3 |
| A Action-Packed Display of a Frisbee And a Pastry Chef who must Pursue a Crocodile in A Jet Boat                         |      11 |       7 |       5 |       6 |       3 |
| A Action-Packed Display of a Mad Cow And a Astronaut who must Kill a Car in Ancient India                                |      14 |       2 |       7 |       5 |       2 |
| A Action-Packed Display of a Man And a Waitress who must Build a Dog in A MySQL Convention                               |      11 |       3 |       6 |       6 |       2 |
| A Action-Packed Display of a Sumo Wrestler And a Car who must Overcome a Waitress in A Baloon Factory                    |      13 |       6 |       4 |       9 |       2 |
| A Action-Packed Display of a Woman And a Dentist who must Redeem a Forensic Psychologist in The Canadian Rockies         |      12 |       8 |       8 |       8 |       1 |
| A Action-Packed Drama of a Dentist And a Crocodile who must Battle a Feminist in The Canadian Rockies                    |      13 |       7 |       8 |       6 |       1 |
| A Action-Packed Drama of a Feminist And a Girl who must Reach a Robot in The Canadian Rockies                            |      13 |       5 |       7 |       6 |       1 |
| A Action-Packed Drama of a Mad Scientist And a Composer who must Outgun a Car in Australia                               |      14 |       3 |       5 |       6 |       4 |
| A Action-Packed Drama of a Monkey And a Dentist who must Chase a Butler in Berlin                                        |      10 |       6 |       4 |       4 |       2 |
| A Action-Packed Epistle of a Dentist And a Moose who must Meet a Mad Cow in Ancient Japan                                |      11 |       8 |       5 |       6 |       1 |
| A Action-Packed Epistle of a Feminist And a Astronaut who must Conquer a Boat in A Manhattan Penthouse                   |      14 |       7 |       5 |       7 |       4 |
| A Action-Packed Epistle of a Robot And a Car who must Chase a Boat in Ancient Japan                                      |      13 |       5 |       4 |       6 |       1 |
| A Action-Packed Panorama of a Husband And a Feminist who must Meet a Forensic Psychologist in Ancient Japan              |      14 |       6 |       7 |       7 |       2 |
| A Action-Packed Panorama of a Mad Cow And a Composer who must Discover a Robot in A Baloon Factory                       |      14 |       3 |       3 |      13 |       1 |
| A Action-Packed Panorama of a Mad Scientist And a Robot who must Challenge a Student in Nigeria                          |      13 |       6 |       6 |       6 |       2 |
| A Action-Packed Panorama of a Technical Writer And a Man who must Build a Forensic Psychologist in A Manhattan Penthouse |      16 |       6 |       7 |       8 |       3 |
+--------------------------------------------------------------------------------------------------------------------------+---------+---------+---------+---------+---------+









4. Display the payments made by each customer( By the way I will be using the limit clause to reduce the output becuase every month and every day will have a lot of entries but for checking the exact answer please run the query without any limits


1. Month wise
SELECT 
customer_id, 
SUM(amount) AS monthly_sum, 
MONTH(payment_date) AS payment_month 
FROM payment 
GROUP BY customer_id, payment_month 
ORDER BY payment_month DESC, monthly_sum DESC 
LIMIT 25;
+-------------+-------------+---------------+
| customer_id | monthly_sum | payment_month |
+-------------+-------------+---------------+
|         148 |       87.82 |             8 |
|         410 |       86.83 |             8 |
|         526 |       79.86 |             8 |
|          21 |       79.83 |             8 |
|          15 |       79.82 |             8 |
|         119 |       77.82 |             8 |
|         147 |       76.85 |             8 |
|         373 |       76.85 |             8 |
|         569 |       75.82 |             8 |
|         137 |       74.85 |             8 |
|         259 |       73.85 |             8 |
|         144 |       72.84 |             8 |
|         468 |       71.86 |             8 |
|         181 |       71.84 |             8 |
|         266 |       71.83 |             8 |
|          78 |       70.86 |             8 |
|         198 |       70.84 |             8 |
|         513 |       69.86 |             8 |
|         532 |       69.86 |             8 |
|         274 |       69.84 |             8 |
|         342 |       69.83 |             8 |
|         487 |       68.89 |             8 |
|         280 |       68.88 |             8 |
|          45 |       68.88 |             8 |
|         150 |       68.84 |             8 |
+-------------+-------------+---------------+







2. Year wise
SELECT 
    customer_id, 
    SUM(amount) AS yearly_sum, 
    YEAR(payment_date) AS payment_year 
FROM payment 
GROUP BY customer_id, payment_year 
ORDER BY payment_year DESC, yearly_sum DESC 
LIMIT 10;
+-------------+------------+--------------+
| customer_id | yearly_sum | payment_year |
+-------------+------------+--------------+
|          60 |       9.98 |         2006 |
|          75 |       8.97 |         2006 |
|         267 |       7.98 |         2006 |
|         354 |       7.98 |         2006 |
|         163 |       7.98 |         2006 |
|         155 |       7.98 |         2006 |
|          53 |       7.98 |         2006 |
|         208 |       5.98 |         2006 |
|         516 |       5.98 |         2006 |
|         576 |       5.98 |         2006 |
+-------------+------------+--------------+







3. Week wise
SELECT 
    customer_id, 
    WEEK(payment_date) AS payment_week, 
    SUM(amount) AS weekly_total
FROM payment 
GROUP BY customer_id, payment_week
ORDER BY payment_week DESC, weekly_total DESC
LIMIT 10;
+-------------+--------------+--------------+
| customer_id | payment_week | weekly_total |
+-------------+--------------+--------------+
|         148 |           34 |        46.90 |
|         468 |           34 |        43.91 |
|         103 |           34 |        39.93 |
|         461 |           34 |        38.92 |
|         121 |           34 |        37.93 |
|          81 |           34 |        37.92 |
|         119 |           34 |        37.91 |
|         327 |           34 |        35.94 |
|         445 |           34 |        35.93 |
|         147 |           34 |        35.92 |
+-------------+--------------+--------------+








5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date

MariaDB [sakila]> SELECT     2026 AS year,     CASE         WHEN (2026 % 4 = 0 AND 2026 % 100 != 0) OR (2026 % 400 = 0) THEN 'Leap Year'         ELSE 'Not a Leap Year'     END AS result;
+------+-----------------+
| year | result          |
+------+-----------------+
| 2026 | Not a Leap Year |
+------+-----------------+
1 row in set (0.001 sec)

MariaDB [sakila]> SELECT     2024 AS year,     CASE         WHEN (2024 % 4 = 0 AND 2024 % 100 != 0) OR (2024 % 400 = 0) THEN 'Leap Year'         ELSE 'Not a Leap Year'     END AS result;
+------+-----------+
| year | result    |
+------+-----------+
| 2024 | Leap Year |
+------+-----------+
1 row in set (0.001 sec)

PS: I had to look online for the leap conditions exactly as I was unaware of the fact that leap year is not just a divisible year by 4 but also 100. Something that I learnt in middle school which I needed to revise ;)








6. Display number of days remaining in the current year from today.
MariaDB [sakila]> select DATEDIFF('2026-12-31', '2026-01-28');
+--------------------------------------+
| DATEDIFF('2026-12-31', '2026-01-28') |
+--------------------------------------+
|                                  337 |
+--------------------------------------+
PS: I am hardcoding today's date and also the end of the year date in the select statement.









7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table. 

SELECT 
    payment_id, 
    payment_date, 
    MONTH(payment_date) AS Month,
    CASE 
        WHEN MONTH(payment_date) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(payment_date) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(payment_date) BETWEEN 7 AND 9 THEN 'Q3'
        WHEN MONTH(payment_date) BETWEEN 10 AND 12 THEN 'Q4'
        ELSE 'calendar only has 12 months'
    END AS Quarter
FROM sakila.payment;
+------------+---------------------+-------+---------+
| payment_id | payment_date        | Month | Quarter |
+------------+---------------------+-------+---------+
|          1 | 2005-05-25 11:30:37 |     5 | Q2      |
|          2 | 2005-05-28 10:35:23 |     5 | Q2      |
|          3 | 2005-06-15 00:54:12 |     6 | Q2      |
|          4 | 2005-06-15 18:02:53 |     6 | Q2      |
|          5 | 2005-06-15 21:08:46 |     6 | Q2      |
|          6 | 2005-06-16 15:18:57 |     6 | Q2      |
|          7 | 2005-06-18 08:41:48 |     6 | Q2      |
|          8 | 2005-06-18 13:33:59 |     6 | Q2      |
|          9 | 2005-06-21 06:24:45 |     6 | Q2      |
|         10 | 2005-07-08 03:17:05 |     7 | Q3      |
+------------+---------------------+-------+---------+


PS: A funny observation I made by adding a where clause to the above query and found out there were no payments made in the fourth Quarter which is Year End when people spend the most ;)









8. Display the age in year, months, days based on your date of birth. 
   For example: 21 years, 4 months, 12 days

SELECT 
    '1998-06-14' AS DOB,
    '2026-01-28' AS Today,
    TIMESTAMPDIFF(YEAR, '1998-06-14', '2026-01-28') AS Years,
    TIMESTAMPDIFF(MONTH, '1998-06-14', '2026-01-28') % 12 AS Months,
    mod(mod(datediff('2026-01-28','1998-06-14'),365),30) AS Days;
+------------+------------+-------+--------+------+
| DOB        | Today      | Years | Months | Days |
+------------+------------+-------+--------+------+
| 1998-06-14 | 2026-01-28 |    27 |      7 |   25 |
+------------+------------+-------+--------+------+



PS: I tried implementing first with DATEDIFF() but was running into accuracy errors with days so then I had to look up documentation for TIMESTAMPDIFF()
MariaDB [sakila]> select '1998-06-14','2026-01-28', mod(mod(datediff('2026-01-28','1998-06-14'),365),12);

Also my MOD() logic is not accurate and leap year proof becuase there were some leap years in my lifespan and also the logic of MOD() assumes that every year is exactly 365 days and every month has exactly 30 days. I know this is not perfect and I would like to learn the correct way of finding the number of remaining days in the next class. I will save this at the end of the next session for doubt ! 















