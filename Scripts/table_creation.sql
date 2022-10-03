CREATE TABLE IF NOT EXISTS forest_area (
   country_code TEXT,
   country_name TEXT ,
   year TEXT,
   forest_area_sqkm DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS land_area (
   country_code TEXT,
   country_name TEXT ,
   year TEXT,
   total_area_sq_mi DOUBLE PRECISION
);

CREATE TABLE IF NOT EXISTS regions (
   country_code TEXT,
   country_name TEXT ,
   region TEXT,
   income_group TEXT
);