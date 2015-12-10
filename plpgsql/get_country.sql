/*

get_country function

determine which country the centroid of a geometry object is located

a table called country_osm_grid is required to make this work

It can be downloaded from nominatim git at:
https://github.com/twain47/Nominatim/blob/master/data/country_osm_grid.sql

(c) 2015-2016 Sven Geggus <svn-osm@geggus.net>

example call:

yourdb=# select get_country(ST_GeomFromText('POINT(9 49)', 4326));
 get_country 
 -------------
  de
  (1 row)
  
*/

CREATE or REPLACE FUNCTION get_country(feature geometry) RETURNS TEXT AS $$
 DECLARE
  country text;
 BEGIN
   SELECT country_code into country
   from country_osm_grid
   where st_contains(geometry, st_centroid(st_transform(feature,4326)));
   return country;
 END;
$$ LANGUAGE 'plpgsql';
  