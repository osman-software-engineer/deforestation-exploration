select *
from forestation
WHERE country_name = 'World';

-- ### a. Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? What was the difference in forest area for each?
WITH forestation_1990 AS
         (SELECT country_name, region, forest_area_sqkm
          FROM forestation
          WHERE year = 1990
            AND forest_area_sqkm IS NOT NULL
            AND country_name != 'World'
          GROUP BY country_name, region, forest_area_sqkm
          ORDER BY forest_area_sqkm DESC),
     forestation_2016 AS
         (SELECT country_name, region, forest_area_sqkm
          FROM forestation
          WHERE year = 2016
            AND forest_area_sqkm IS NOT NULL
            AND country_name != 'World'
          GROUP BY country_name, region, forest_area_sqkm
          ORDER BY forest_area_sqkm DESC)
SELECT forestation_1990.country_name,
       forestation_1990.region,
       (round((forestation_1990.forest_area_sqkm)::numeric, 2) -
        round((forestation_2016.forest_area_sqkm)::numeric, 2)) AS difference
FROM forestation_1990
         JOIN forestation_2016
              ON forestation_2016.country_name = forestation_1990.country_name
ORDER BY difference DESC
LIMIT 5;

--### b. Which 5 countries saw the largest percent decrease in forest area from 1990 to 2016? What was the percent change to 2 decimal places for each?
WITH forestation_1990 AS
         (SELECT country_name, region, forest_percentage
          FROM forestation
          WHERE year = 1990
            AND forest_percentage IS NOT NULL
            AND country_name != 'World'
          GROUP BY country_name, forest_percentage, region
          ORDER BY forest_percentage DESC),
     forestation_2016 AS
         (SELECT country_name, region, forest_percentage
          FROM forestation
          WHERE year = 2016
            AND forest_percentage IS NOT NULL
            AND country_name != 'World'
          GROUP BY country_name, forest_percentage, region
          ORDER BY forest_percentage DESC)
SELECT forestation_1990.country_name,
       forestation_1990.region,
       (round((forestation_1990.forest_percentage)::numeric, 2) -
        round((forestation_2016.forest_percentage)::numeric, 2)) AS percent_difference
FROM forestation_1990
         JOIN forestation_2016
              ON forestation_2016.country_name = forestation_1990.country_name
ORDER BY percent_difference DESC
LIMIT 5;

--### c. If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016?
WITH t1 AS
         (SELECT country_name,
                 year,
                 forest_percentage
          FROM forestation
          WHERE year = 2016
            AND region != 'World'
          GROUP BY country_name,
                   year,
                   forest_area_sqkm, forest_percentage)
SELECT Distinct(quartiles),
               count(country_name) Over (PARTITION BY quartiles)
FROM (SELECT country_name,
             CASE
                 WHEN forest_percentage < 25 THEN '1st Quarter'
                 WHEN forest_percentage >= 25
                     AND forest_percentage < 50 THEN '2nd Quarter'
                 WHEN forest_percentage >= 50
                     AND forest_percentage < 75 THEN '3rd Quarter'
                 ELSE '4th Quarter'
                 END AS quartiles
      FROM t1
      WHERE forest_percentage IS NOT NULL
        AND year = 2016) sub
ORDER BY quartiles;
--### d. List all of the countries that were in the 4th quartile (percent forest > 75%) in 2016.

--### e. How many countries had a percent forestation higher than the United States in 2016?