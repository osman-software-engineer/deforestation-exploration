-- 1. What was the total forest area (in sq km) of the world in 1990? Please keep in mind that you can use the country record in the table is denoted as “World.”
SELECT forest_area_sqkm
FROM forestation
WHERE region = 'World'
  AND year = 1990;

-- 2. What was the total forest area (in sq km) of the world in 2016? Please keep in mind that you can use the country record in the table is denoted as “World.”
SELECT forest_area_sqkm
FROM forestation
WHERE region = 'World'
  AND year = 2016;

-- 3. What was the change (in sq km) in the forest area of the world from 1990 to 2016?
SELECT forest_area_1990.forest_area_sqkm - forest_area_2016.forest_area_sqkm as change_sqkm
FROM (SELECT fview.forest_area_sqkm
      FROM forestation fview
      WHERE region = 'World' and year = 1990) AS forest_area_1990
JOIN (SELECT fview.forest_area_sqkm
      FROM forestation fview
      WHERE region = 'World' and year = 2016) AS forest_area_2016
ON forest_area_1990.forest_area_sqkm = forest_area_1990.forest_area_sqkm;

-- 4. What was the percent change in forest area of the world between 1990 and 2016?
SELECT forest_area_1990.forest_percentage - forest_area_2016.forest_percentage as change
FROM (SELECT fview.forest_percentage
      FROM forestation fview
      WHERE region = 'World' and year = 1990) AS forest_area_1990
JOIN (SELECT fview.forest_percentage
      FROM forestation fview
      WHERE region = 'World' and year = 2016) AS forest_area_2016
ON forest_area_1990.forest_percentage = forest_area_1990.forest_percentage;

-- 5. If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?
SELECT fview.country_name, fview.total_area_sq_mi
FROM forestation fview
WHERE fview.total_area_sq_mi <= (SELECT sub.change_sqkm / 2.59 AS total_area_sq_mi
                                 FROM (SELECT forest_area_1990.forest_area_sqkm - forest_area_2016.forest_area_sqkm as change_sqkm
                                       FROM (SELECT fview.forest_area_sqkm
                                             FROM forestation fview
                                             WHERE region = 'World'
                                               and year = 1990) AS forest_area_1990
                                                JOIN (SELECT fview.forest_area_sqkm
                                                      FROM forestation fview
                                                      WHERE region = 'World'
                                                        and year = 2016) AS forest_area_2016
                                                     ON forest_area_1990.forest_area_sqkm = forest_area_1990.forest_area_sqkm) AS sub)
ORDER BY fview.total_area_sq_mi DESC
LIMIT 1;