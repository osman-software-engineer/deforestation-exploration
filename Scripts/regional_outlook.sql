-- Create a table that shows the Regions and their percent forest area (sum of forest area divided by sum of land area) in 1990 and 2016. (Note that 1 sq mi = 2.59 sq km)
CREATE VIEW forestation_regional
AS
(SELECT year,
       region,
       SUM(forest_area_sqkm) AS forest_area_sqkm,
       SUM(total_area_sq_mi*2.59) AS total_area_sqkm,
        (SUM(forest_area_sqkm)/SUM(total_area_sq_mi*2.59))*100 AS percent_forest_area
FROM forestation
WHERE year = 1990 or year = 2016
GROUP BY year, region
ORDER BY year,region);

-- 1a. What was the percent forest of the entire world in 2016?
SELECT round((percent_forest_area)::numeric,2)
FROM forestation_regional
WHERE region = 'World'
  AND percent_forest_area IS NOT NULL
  AND year = 2016;

-- 1b. Which region had the HIGHEST percent forest in 2016
SELECT region,round((percent_forest_area)::numeric,2) AS forest_percent
FROM forestation_regional
WHERE region != 'World'
  AND percent_forest_area IS NOT NULL
  AND year = 2016
ORDER BY percent_forest_area DESC
LIMIT 1;

-- 1c. Which region had the lowest percent forest in 2016, to 2 decimal places?
SELECT region,round((percent_forest_area)::numeric,2) AS forest_percent
FROM forestation_regional
WHERE region != 'World'
  AND year = 2016
ORDER BY percent_forest_area
LIMIT 1;


-- 2a. What was the percent forest of the entire world in 1990?
SELECT round((percent_forest_area)::numeric,2)
FROM forestation_regional
WHERE region = 'World'
  AND percent_forest_area IS NOT NULL
  AND year = 1990;

-- 2b. Which region had the HIGHEST percent forest in 1990
SELECT region,round((percent_forest_area)::numeric,2) AS forest_percent
FROM forestation_regional
WHERE region != 'World'
  AND percent_forest_area IS NOT NULL
  AND year = 1990
ORDER BY percent_forest_area DESC
LIMIT 1;

-- 2c. Which region had the lowest percent forest in 1990, to 2 decimal places?
SELECT region,round((percent_forest_area)::numeric,2) AS forest_percent
FROM forestation_regional
WHERE region != 'World'
  AND year = 1990
ORDER BY percent_forest_area
LIMIT 1;

-- 3. Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?
WITH forestation_1990 AS
         (SELECT region, percent_forest_area
          FROM forestation_regional
          WHERE year = 1990
          GROUP BY region, percent_forest_area
          ORDER BY percent_forest_area DESC),
     forestation_2016 AS
         (SELECT region, percent_forest_area
          FROM forestation_regional
          WHERE year = 2016
          GROUP BY region, percent_forest_area
          ORDER BY percent_forest_area DESC)
SELECT forestation_1990.region "Region",
       round((forestation_1990.percent_forest_area)::numeric,2) "1990 Forest Percentage",
       round((forestation_2016.percent_forest_area)::numeric,2) "2016 Forest Percentage"
FROM forestation_1990
         JOIN forestation_2016
              ON forestation_1990.region = forestation_2016.region;

