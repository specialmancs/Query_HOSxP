/* WBC */
SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p.person_id AS PID,
pn.vn AS SEQ,
IF(pn.nutrition_date IS NULL OR TRIM(pn.nutrition_date)='' OR pn.nutrition_date LIKE '0000-00-00%','',DATE_FORMAT(pn.nutrition_date,'%Y%m%d')) AS DATE_SERV,
(SELECT hospitalcode FROM opdconfig) AS NUTRITIONPLACE,
IF(pn.body_weight IS NOT NULL AND TRIM(pn.body_weight)<>'', REPLACE(FORMAT(pn.body_weight,1),',',''), FORMAT(0,1)) AS WEIGHT,
IF(pn.height IS NOT NULL AND TRIM(pn.height )<>'', REPLACE(FORMAT(pn.height ,0),',',''), FORMAT(0,0)) AS HEIGHT,
IF(pn.head_circum_cm IS NOT NULL AND TRIM(pn.head_circum_cm)<>'', REPLACE(FORMAT(pn.head_circum_cm,0),',',''), FORMAT(0,0))HEADCIRCUM,
pn.person_nutrition_childdevelop_type_id AS CHILDDEVELOP,
pn.person_nutrition_food_type_id AS FOOD,
pn.person_nutrition_bottle_type_id AS BOTTLE,
(SELECT cid FROM doctor WHERE pn.doctor_code = `code`) AS PROVIDER,
CASE 
WHEN pn.update_datetime IS NOT NULL OR pn.update_datetime <> ''  THEN DATE_FORMAT((pn.update_datetime),"%Y%m%d%H%i%s")
WHEN pn.update_datetime IS NULL OR pn.update_datetime = ''  THEN DATE_FORMAT((pn.nutrition_date),"%Y%m%d%H%i%s")
ELSE NULL END
AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_wbc_nutrition pn  
LEFT OUTER JOIN person_wbc a ON pn.person_wbc_id=a.person_wbc_id /* baby 0 - 5 Year */
LEFT OUTER JOIN person p ON p.person_id = a.person_id 
LEFT OUTER JOIN breast_feed_status bf ON bf.breast_feed_status_id = a.breast_feed_status_id  
LEFT OUTER JOIN house h ON h.house_id = p.house_id  
LEFT OUTER JOIN village v ON v.village_id = p.village_id  
LEFT OUTER JOIN thaiaddress t ON t.addressid = v.address_id  

WHERE (a.discharge<>'Y' OR a.discharge IS NULL)  
AND p.person_id IS NOT NULL
AND  pn.nutrition_date BETWEEN 20160501 AND 20160530

UNION ALL

/* EPI */
SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p.person_id AS PID,
pn.vn AS SEQ,
IF(pn.nutrition_date IS NULL OR TRIM(pn.nutrition_date)='' OR pn.nutrition_date LIKE '0000-00-00%','',DATE_FORMAT(pn.nutrition_date,'%Y%m%d')) AS DATE_SERV,
(SELECT hospitalcode FROM opdconfig) AS NUTRITIONPLACE,
IF(pn.body_weight IS NOT NULL AND TRIM(pn.body_weight)<>'', REPLACE(FORMAT(pn.body_weight,1),',',''), FORMAT(0,1)) AS WEIGHT,
IF(pn.height IS NOT NULL AND TRIM(pn.height )<>'', REPLACE(FORMAT(pn.height ,0),',',''), FORMAT(0,0)) AS HEIGHT,
IF(pn.head_circum_cm IS NOT NULL AND TRIM(pn.head_circum_cm)<>'', REPLACE(FORMAT(pn.head_circum_cm,0),',',''), FORMAT(0,0))HEADCIRCUM,
pn.person_nutrition_childdevelop_type_id AS CHILDDEVELOP,
pn.person_nutrition_food_type_id AS FOOD,
pn.person_nutrition_bottle_type_id AS BOTTLE,
(SELECT cid FROM doctor WHERE pn.doctor_code = `code`) AS PROVIDER,
CASE 
WHEN pn.update_datetime IS NOT NULL OR pn.update_datetime <> ''  THEN DATE_FORMAT((pn.update_datetime),"%Y%m%d%H%i%s")
WHEN pn.update_datetime IS NULL OR pn.update_datetime = ''  THEN DATE_FORMAT((pn.nutrition_date),"%Y%m%d%H%i%s")
ELSE NULL END
AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_epi_nutrition pn
LEFT JOIN person_epi_vaccine e2 ON pn.person_epi_id = e2.person_epi_id AND pn.vn=e2.vn
LEFT JOIN person_epi e1 ON pn.person_epi_id = e1.person_epi_id 
LEFT OUTER JOIN person p ON p.person_id = e1.person_id 
WHERE p.person_id IS NOT NULL
AND pn.nutrition_date BETWEEN 20160501 AND 20160530

UNION ALL 

/* Student */
SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p.person_id AS PID,
e2.vn AS SEQ,
IF(pn.screen_date IS NULL OR TRIM(pn.screen_date)='' OR pn.screen_date LIKE '0000-00-00%','',DATE_FORMAT(pn.screen_date,'%Y%m%d')) AS DATE_SERV,
(SELECT hospitalcode FROM opdconfig) AS NUTRITIONPLACE,
IF(pn.body_weight IS NOT NULL AND TRIM(pn.body_weight)<>'', REPLACE(FORMAT(pn.body_weight,1),',',''), FORMAT(0,1)) AS WEIGHT,
IF(pn.height IS NOT NULL AND TRIM(pn.height )<>'', REPLACE(FORMAT(pn.height ,0),',',''), FORMAT(0,0)) AS HEIGHT,
IF(pn.head_circum_cm IS NOT NULL AND TRIM(pn.head_circum_cm)<>'', REPLACE(FORMAT(pn.head_circum_cm,0),',',''), FORMAT(0,0))HEADCIRCUM,
pn.person_nutrition_childdevelop_type_id AS CHILDDEVELOP,
pn.person_nutrition_food_type_id AS FOOD,
pn.person_nutrition_bottle_type_id AS BOTTLE,
(SELECT cid FROM doctor WHERE pn.doctor_code = `code`) AS PROVIDER,
CASE 
WHEN pn.update_datetime IS NOT NULL OR pn.update_datetime <> ''  THEN DATE_FORMAT((pn.update_datetime),"%Y%m%d%H%i%s")
WHEN pn.update_datetime IS NULL OR pn.update_datetime = ''  THEN DATE_FORMAT(CONCAT(pn.screen_date,' ',pn.screen_time),"%Y%m%d%H%i%s")
ELSE NULL END
AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM village_student_screen pn
LEFT JOIN village_student_vaccine e2 ON pn.village_student_id = e2.village_student_id
LEFT JOIN village_student e1 ON pn.village_student_id = e1.village_student_id
LEFT OUTER JOIN person p ON p.person_id = e1.person_id 
WHERE p.person_id IS NOT NULL
AND pn.screen_date BETWEEN 20160501 AND 20160530
