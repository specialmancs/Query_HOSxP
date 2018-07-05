SELECT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
h.house_id AS HID,
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(h.census_id,'-',''),' ',''),'\t',''),'\n',''),'\r','') AS HOUSE_ID,
h.house_type_id  AS HOUSETYPE,
h.house_condo_roomno AS ROOMNO,
h.house_condo_name AS CONDO,
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(h.address,'-',''),' ',''),'\t',''),'\n',''),'\r','')AS HOUSE,
'' AS SOISUB,
'' AS SOIMAIN,
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(h.road,'-',''),' ',''),'\t',''),'\n',''),'\r','')AS ROAD,
v.village_name AS VILLANAME,
v.village_moo AS VILLAGE,
SUBSTR(v.address_id,5,2) AS TAMBON,
SUBSTR(v.address_id,3,2) AS AMPUR,
SUBSTR(v.address_id,1,2) AS CHANGWAT,
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(p.hometel,'-',''),' ',''),'\t',''),'\n',''),'\r','') AS TELEPHONE,
h.latitude AS LATITUDE,
h.longitude AS LONGITUDE,
IF(h.family_count IS NOT NULL OR TRIM(h.family_count )<>'', REPLACE(FORMAT(h.family_count ,2),',',''), FORMAT(0,0)) AS NFAMILY,
(SELECT CASE (h.location_area_id) 
WHEN "1" THEN '1'
WHEN "2" THEN '2'
ELSE '2' END) AS LOCATYPE,
p.care_person_name AS VHVID,
p2.cid   AS HEADID,
(SELECT CASE(hss.house_survey_item_id = 3)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS TOILET,
(SELECT CASE(hss.house_survey_item_id = 1)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS WATER,
(SELECT CASE(hss.house_survey_item_id = 2)
WHEN hss.house_item_value = '1' THEN '2'
WHEN hss.house_item_value = '2' THEN '4'
WHEN hss.house_item_value = '3' THEN '1'
WHEN hss.house_item_value = '4' THEN '6'
WHEN hss.house_item_value = '5' THEN '5'
WHEN hss.house_item_value = '6' THEN '3'
ELSE '9' end) AS WATERTYPE,
(SELECT CASE(hss.house_survey_item_id = 6)
WHEN hss.house_item_value = '1' THEN '2'
WHEN hss.house_item_value = '2' THEN '3'
WHEN hss.house_item_value = '3' THEN '2'
WHEN hss.house_item_value = '4' THEN '4'
ELSE '9' end) AS GARBAGE,
(SELECT CASE(hss.house_survey_item_id = 13)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS HOUSING,
(SELECT CASE(hss.house_survey_item_id = 8)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS DURABILITY,
(SELECT CASE(hss.house_survey_item_id = 9)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS CLEANLINESS,
(SELECT CASE(hss.house_survey_item_id = 11)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS VENTILATION,
(SELECT CASE(hss.house_survey_item_id = 12)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS LIGHT,
(SELECT CASE(hss.house_survey_item_id = 14)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS WATERTM,
(SELECT CASE(hss.house_survey_item_id = 15)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS MFOOD,
(SELECT CASE(hss.house_survey_item_id = 24)
WHEN hss.house_item_value = '1' THEN '1'
WHEN hss.house_item_value = '2' THEN '0'
ELSE '9' end) AS BCONTROL,
'' AS ACONTROL,
'' AS CHEMICAL,
'' AS OUTDATE,
IF( h.last_update IS NULL OR TRIM(h.last_update )='' OR h.last_update LIKE '0000-00-00%','',DATE_FORMAT(h.last_update ,'%Y%m%d%H%i%s') ) AS D_UPDATE
FROM house   h  
LEFT OUTER JOIN person p on p.house_id = h.house_id 
LEFT OUTER JOIN person p2 on p2.house_id = h.house_id AND p2.person_house_position_id = 1
LEFT JOIN village v ON h.village_id = v.village_id
LEFT OUTER JOIN house_survey hs ON h.house_id = hs.house_id
LEFT OUTER JOIN house_survey_detail hss ON  hss.house_survey_id = hs.house_survey_id

WHERE h.village_id NOT IN (SELECT village.village_id FROM village WHERE village.village_id = h.village_id AND village.village_moo = '0')
AND h.last_update BETWEEN 20171001 AND 20180131 

GROUP BY  h.house_id,h.census_id,h.address,h.road
/*Design By TAKIS TEAM 05/03/2558*/