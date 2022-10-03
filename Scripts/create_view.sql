CREATE VIEW forestation AS
SELECT fa.country_code,
       fa.country_name,
       fa.year,
       fa.forest_area_sqkm,
       la.total_area_sq_mi,
       r.region,
       r.income_group,
       (fa.forest_area_sqkm / (la.total_area_sq_mi * 2.59)) * 100 AS forest_percentage
FROM forest_area fa
         JOIN land_area la ON fa.country_code = la.country_code AND fa.year = la.year
         JOIN regions r ON la.country_code = r.country_code