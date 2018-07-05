SELECT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
psl.person_id AS PID,
p.mother_person_id AS MPID,
psl.gravida AS GRAVIDA,
psl.ga AS GA,
IFNULL(DATE_FORMAT(p.birthdate,'%Y%m%d'),'') AS BDATE,
IFNULL(DATE_FORMAT(p.birthtime,'%H%i%s'),'')AS BTIME,
psl.person_labour_place_id AS BPLACE,
psl.labour_hospcode AS BHOSP,
psl.person_labour_birth_no_id AS BIRTHNO,
psl.person_labour_type_id AS BTYPE,
psl.person_labour_doctor_type_id AS BDOCTOR,
psl.birth_weight AS BWEIGHT,
(SELECT CASE psl.has_asphyxia
WHEN 'Y' THEN '1'
WHEN 'N' THEN '0'
ELSE '0'  END )AS ASPHYXIA,
(SELECT CASE psl.has_vitk
WHEN 'Y' THEN '1'
WHEN 'N' THEN '0'
ELSE '9' END )AS VITK,
(SELECT CASE psl.thyroid_screen
WHEN 'Y' THEN '1'
WHEN 'N' THEN '2'
ELSE '9' END )AS TSH,
IF(psl.tsh_result IS NOT NULL OR psl.tsh_result <> '',FORMAT(psl.tsh_result,1),'') AS TSHRESULT, 
IF(p.last_update IS NULL OR TRIM(p.last_update)='' OR p.last_update LIKE '0000-00-00%','',DATE_FORMAT(p.last_update,'%Y%m%d%h%m%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM
person_labour psl
LEFT OUTER JOIN person p ON p.person_id = psl.person_id
where p.birthdate BETWEEN 20160501 AND 20160530
#WHERE p.village_id IN (SELECT village.village_id FROM village WHERE village.out_region_date IS NULL OR village.out_region_date = '')
ORDER BY psl.person_id
/*WHERE p.person_id = 94569*/
/*Design By Glison 07/03/2558*/