COPY forest_area(country_code, country_name, year, forest_area_sqkm)
FROM 'C:\Users\mdosm\DataGripProjects\sql-project-1\Data\forest_area_table_results.csv'
DELIMITER ','
CSV HEADER;


COPY land_area(country_code, country_name, year, total_area_sq_mi)
FROM 'C:\Users\mdosm\DataGripProjects\sql-project-1\Data\land_area_table_results.csv'
DELIMITER ','
CSV HEADER;

COPY regions(country_code, country_name, region, income_group)
FROM 'C:\Users\mdosm\DataGripProjects\sql-project-1\Data\regions_table_results.csv'
DELIMITER ','
CSV HEADER;