#For HOSxP 
SELECT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE, 
vs.person_id AS PID, 
vs.village_school_class_id AS CLASSCODE, 
vs.village_school_id AS SCHOOLCODE, 
CASE MONTH(NOW())
WHEN '1'  THEN (LEFT(NOW(),4) + 542)
WHEN '2'  THEN (LEFT(NOW(),4) + 542)
WHEN '3'  THEN (LEFT(NOW(),4) + 542)
ELSE (LEFT(NOW(),4)+ 543) END  AS YEAR_EDUCATION,
v.village_code AS VILLCODE, 
p.cid AS CID,
p3.patient_hn as HN,
concat(p3.pname,p3.fname," ",p3.lname) as ptname,
p3.house_regist_type_id as typearea,
p3.person_discharge_id as discharge
 
FROM village_student vs 
INNER JOIN village_school vsc ON vsc.village_school_id = vs.village_school_id 
INNER JOIN village v ON v.village_id = vsc.village_id 
INNER JOIN village_school_class vc ON vc.village_school_class_id = vs.village_school_class_id 
INNER JOIN person p ON p.person_id = vs.person_id 
WHERE (vs.discharge = 'N' OR vs.discharge IS NULL) AND RIGHT(v.village_code,2) <> '00' 
/* 	MODIFY BY GLISON 03/03/2558 */