SELECT  DISTINCT
	(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
	v.village_code AS VID,
	s.village_school_id AS SCHOOLCODE,
	s.gov_school_code AS SCHOOLID,
	s.school_name AS SCHOOLNAME,
	IFNULL(s.f53_school_owner_code,'99') AS SCHOOLOWNER,
	RIGHT(s.f53_school_type_code,1) AS SCHOOLTYPE,
	s.closed_date AS CLOSEDDATE,
	s.update_datetime AS D_UPDATE
FROM village_school s
#SELECT v.village_code from village_school s
INNER JOIN village v ON v.village_id = s.village_id 