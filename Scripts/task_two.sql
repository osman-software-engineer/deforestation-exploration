-- 1. What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record in the table is denoted as “World.”
SELECT * from forestation WHERE region = 'World' and year = 1990;

-- 2. What was the total forest area (in sq km) of the world in 2016? Please keep in mind that you can use the country record in the table is denoted as “World.”
SELECT * from forestation WHERE region = 'World' and year = 2016;

-- 3. What was the change (in sq km) in the forest area of the world from 1990 to 2016?
WITH forest_area_1990 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
   FROM sales_reps s
   JOIN accounts a
   ON a.sales_rep_id = s.id
   JOIN orders o
   ON o.account_id = a.id
   JOIN region r
   ON r.id = s.region_id
   GROUP BY 1,2
   ORDER BY 3 DESC),
t2 AS (
   SELECT region_name, MAX(total_amt) total_amt
   FROM t1
   GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;


-- 4. What was the percent change in forest area of the world between 1990 and 2016?

-- 5. If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?