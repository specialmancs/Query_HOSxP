SELECT  DISTINCT
	(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
	#IFNULL(p.cid,'') AS PID,
	IFNULL(p.person_id,'') AS PID,
	s.village_school_id AS SCHOOLCODE,
	st.education_year as EDUCATIONYEAR,

(SELECT CASE c.village_school_class_id
	WHEN  '0' THEN  '00'
	WHEN  '1' THEN  '01'
	WHEN  '2' THEN  '02'
	WHEN  '3' THEN  '03'
	WHEN  '4' THEN  '11'
	WHEN  '5' THEN  '12'
	WHEN  '6' THEN  '13'
	WHEN  '7' THEN  '21'
	WHEN  '8' THEN  '22'
	WHEN  '9' THEN  '23'
	WHEN  '10' THEN  '31'
	WHEN  '11' THEN  '32'
	WHEN  '12' THEN  '33'
	WHEN  '13' THEN  '41'
	WHEN  '14' THEN  '42'
	WHEN  '15' THEN  '43'
	ELSE '' END ) AS CLASS,

	st.last_update AS D_UPDATE
 FROM village_student st
 LEFT OUTER JOIN village_school s ON st.village_school_id = s.village_school_id
 LEFT JOIN village_school_class c ON st.village_school_class_id = c.village_school_class_id
 LEFT JOIN person p ON st.person_id = p.person_id 


