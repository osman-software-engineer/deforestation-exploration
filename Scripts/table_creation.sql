CREATE TABLE IF NOT EXISTS forestation_table
(
    country_code      TEXT,
    country_name      TEXT,
    year              BIGINT,
    forest_area_sqkm  DOUBLE PRECISION,
    total_area_sq_mi  DOUBLE PRECISION,
    region            TEXT,
    income_group      TEXT,
    forest_percentage DOUBLE PRECISION
);