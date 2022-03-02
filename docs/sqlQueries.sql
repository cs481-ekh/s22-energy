 /* grab the utility_name in the utility table Based Off utility_id */
SELECT utility_type FROM utilities WHERE utility_id =  '';

/* grab the building_code in the buildings table based on a given premise_id */
SELECT building_code FROM premise WHERE premise_id = '60420117';

/* join the bulidngs table with the meter table on the building code */
SELECT meter.meter_id , usage.usage, usage.building_code 
FROM meter 
JOIN usage ON meter.building_code = usage.building_code;

/* join the bulidngs table with the premise table based on the building code */
SELECT premise.premise_id , meter.meter_id, meter.building_code, meter.utility_id 
FROM meter 
JOIN premise  
ON premise.building_code = premise.building_code;


/* filtering our usage table based off a given timestamp (or to pull the entire table) if that timestamp is not given */

	SELECT * 
    FROM    usage
    WHERE  books.pages > 200 
    GROUP BY au.name
    ORDER BY PageCount DESC
	
/* query for joining meter, premise and buildings based on the building_code*/
select buildings.building_code, buildings.gross_sf, premise.premise_id, meter.meter_id
FROM buildings
JOIN meter 
ON meter.building_code = buildings.building_code 
JOIN premise 
ON meter.building_code = premise.building_code;

/* query counting  the number of distinct building with a given name*/
SELECT COUNT(building_code)
FROM buildings
WHERE (building_name = 'University Square - D');