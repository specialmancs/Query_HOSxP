SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,  
p.person_id AS PID, 
pws.vn AS SEQ, 
IF(p.birthdate IS NULL OR TRIM(p.birthdate)='' OR p.birthdate LIKE '0000-00-00%','',DATE_FORMAT(p.birthdate,'%Y%m%d')) AS BDATE, 
IF(pbc.care_date IS NULL OR TRIM(pbc.care_date)='' OR pbc.care_date LIKE '0000-00-00%','',DATE_FORMAT(pbc.care_date,'%Y%m%d'))AS BCARE,
(SELECT hospitalcode FROM opdconfig) AS BCPLACE, 
(SELECT CASE pbc.person_wbc_post_care_result_type_id 
WHEN '1' THEN '1'
WHEN '2' THEN '2'
ELSE '9'  END )AS BCARERESULT,
pbc.person_nutrition_food_type_id AS FOOD,
(SELECT cid FROM doctor WHERE pbc.doctor_code = doctor.`code`)AS PROVIDER,
IF(pw.last_update IS NULL OR TRIM(pw.last_update)='' OR pw.last_update LIKE '0000-00-00%','',DATE_FORMAT(pw.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM  person_wbc_post_care pbc
LEFT OUTER JOIN person_wbc pw ON pw.person_wbc_id=pbc.person_wbc_id
LEFT OUTER JOIN person_wbc_service pws ON pws.person_wbc_id=pbc.person_wbc_id
LEFT OUTER JOIN person p ON pw.person_id=p.person_id

WHERE pbc.care_date between 20160501 AND 20160530
#WHERE pbc.person_wbc_post_care_id = 5283
#WHERE p.village_id IN (SELECT village.village_id FROM village WHERE village.out_region_date IS NULL OR village.out_region_date = '')
GROUP BY pbc.person_wbc_post_care_id 
/*Design By TAKIS TEAM 07/03/2558*/