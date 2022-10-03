COPY forest_area(country_code, country_name, year, forest_area_sqkm)
FROM 'C:\Users\mdosm\Downloads\forest_area_table_results.csv'
DELIMITER ','
CSV HEADER;


COPY land_area(country_code, country_name, year, total_area_sq_mi)
FROM 'C:\Users\mdosm\Downloads\land_area_table_results.csv'
DELIMITER ','
CSV HEADER;