
SELECT DISTINCT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p.cid AS CID,
p.person_id AS PID,
p.house_id AS HID, 
IF(pn.provis_code IN(SELECT provis_pname_code FROM provis_pname),pn.provis_code,pn2.provis_pname_code) AS PRENAME,
p.fname AS NAME,
p.lname AS LNAME,
p.patient_hn AS HN, 
p.sex AS SEX,
IF(p.birthdate IS NULL OR TRIM(p.birthdate)='' OR p.birthdate LIKE '0000-00-00%','',DATE_FORMAT(p.birthdate,'%Y%m%d')) AS BIRTH,
p.marrystatus AS MSTATUS,
p.occupation AS OCCUPATION_OLD,
(SELECT oc.nhso_code FROM occupation oc WHERE oc.occupation=p.occupation) AS OCCUPATION_NEW,
(SELECT nhso_code FROM nationality n WHERE n.nationality=p.citizenship) AS RACE,
(SELECT nhso_code FROM nationality n WHERE n.nationality=p.nationality) AS NATION,
p.religion AS RELIGION,
IF(p.education IS NULL OR p.education = '',9,p.education) AS EDUCATION,
p.person_house_position_id AS FSTATUS,
p.father_cid AS FATHER,
p.mother_cid AS MOTHER,
p.sps_cid AS COUPLE, 
'' AS VSTATUS,
IF(p.movein_date IS NULL OR TRIM(p.movein_date)='' OR p.movein_date LIKE '0000-00-00%','',DATE_FORMAT(p.movein_date,'%Y%m%d')) AS MOVEIN,
IF(p.death <> 'N',1,p.person_discharge_id) AS DISCHARGE, 
IF((IF(p.death <> 'N',d.death_date,p.discharge_date)) IS NULL OR TRIM((IF(p.death <> 'N',d.death_date,p.discharge_date)))='' OR (IF(p.death <> 'N',d.death_date,p.discharge_date)) 
LIKE '0000-00-00%','',DATE_FORMAT((IF(p.death <> 'N',d.death_date,p.discharge_date)),'%Y%m%d')) AS DDISCHARGE,
(SELECT CASE (pb.`code`) 
WHEN '01' THEN '1' 
WHEN '05' THEN '1' 
WHEN '09' THEN '1' 
WHEN '03' THEN '3'
WHEN '07' THEN '3' 
WHEN '11' THEN '3' 
WHEN '02' THEN '2' 
WHEN '06' THEN '2'
WHEN '10' THEN '2' 
WHEN '04' THEN '4' 
WHEN '08' THEN '4' 
WHEN '12' THEN '4'
ELSE NULL END) AS ABOGROUP,
(SELECT CASE (pb.`code`) 
WHEN '01' THEN NULL 
WHEN '05' THEN '2' 
WHEN '09' THEN '1' 
WHEN '03' THEN NULL
WHEN '07' THEN '2' 
WHEN '11' THEN '1' 
WHEN '02' THEN NULL 
WHEN '06' THEN '2'
WHEN '10' THEN '1' 
WHEN '04' THEN NULL 
WHEN '08' THEN '2' 
WHEN '12' THEN '1'
ELSE NULL END) AS RHGROUP,
(SELECT nhso_code FROM person_labor_type pl WHERE pl.person_labor_type_id=p.person_labor_type_id) AS LABOR,
'' AS PASSPORT,
IF(p.house_regist_type_id IN ('0',' ') OR p.house_regist_type_id IS NULL,5,p.house_regist_type_id) AS TYPEAREA, 
IF(p.last_update IS NULL OR TRIM(p.last_update )='' OR p.last_update LIKE '0000-00-00%','',DATE_FORMAT(p.last_update ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.hometel AS TELEPHONE,
p.mobile_phone AS MOBILE
FROM person p 
LEFT JOIN provis_bgroup pb ON p.blood_group = pb.name
LEFT JOIN pname pn ON p.pname = pn.name
LEFT JOIN provis_pname pn2 ON p.pname = pn2.provis_pname_short_name
LEFT JOIN person_labor_type pl ON p.person_labor_type_id = pl.person_labor_type_id
LEFT JOIN person_death d ON p.person_id = d.person_id 
LEFT JOIN village_organization_member vm ON p.person_id=vm.person_id
LEFT JOIN vn_stat v ON v.hn = p.patient_hn
WHERE (p.cid <> '' OR p.cid IS NOT NULL) 
AND (p.person_id <> '' OR p.person_id IS NOT NULL)
AND (v.vstdate BETWEEN 20180110 AND 20180110
OR p.last_update BETWEEN 20180110 AND 20180110)

UNION ALL

SELECT DISTINCT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
pt.cid AS CID,
pt.hn AS PID,
'' AS HID,
IF(pn.provis_code IN(SELECT provis_pname_code FROM provis_pname),pn.provis_code,pn2.provis_pname_code) AS PRENAME,
pt.fname AS NAME,
pt.lname AS LNAME,
pt.hn AS HN, 
pt.sex AS SEX,
IF(pt.birthday IS NULL OR TRIM(pt.birthday)='' OR pt.birthday LIKE '0000-00-00%','',DATE_FORMAT(pt.birthday,'%Y%m%d')) AS BIRTH,
pt.marrystatus AS MSTATUS,
pt.occupation AS OCCUPATION_OLD,
(SELECT oc.nhso_code FROM occupation oc WHERE oc.occupation=pt.occupation) AS OCCUPATION_NEW,
(SELECT nhso_code FROM nationality n WHERE n.nationality=pt.citizenship) AS RACE,
(SELECT nhso_code FROM nationality n WHERE n.nationality=pt.nationality) AS NATION,
pt.religion AS RELIGION,
(SELECT CASE (pt.educate) 
WHEN '1' THEN '02'
WHEN '2' THEN '02'
WHEN '3' THEN '03'
WHEN '4' THEN '03'
WHEN '5' THEN '04'
WHEN '6' THEN '05'
WHEN '7' THEN '06'
WHEN '8' THEN '06'
ELSE '00' END) AS EDUCATION,
pt.family_status AS FSTATUS,
pt.father_cid AS FATHER,
pt.mother_cid AS MOTHER,
pt.couple_cid AS COUPLE, 
'' AS VSTATUS,
IF(pt.last_visit IS NULL OR TRIM(pt.last_visit)='' OR pt.last_visit LIKE '0000-00-00%','',DATE_FORMAT(pt.last_visit,'%Y%m%d')) AS MOVEIN,
IF(pt.death = 'Y',1,9) AS DISCHARGE, 
IF((IF(pt.death = 'Y',pt.deathday,NULL)) IS NULL OR TRIM((IF(pt.death = 'Y',pt.deathday,NULL)))='' OR (IF(pt.death = 'Y',pt.deathday,NULL)) 
LIKE '0000-00-00%','',DATE_FORMAT((IF(pt.death = 'Y',pt.deathday,NULL)),'%Y%m%d')) AS DDISCHARGE,
(SELECT CASE (pt.bloodgrp) 
WHEN 'A' THEN '1'
WHEN 'AB' THEN '3'
WHEN 'B' THEN '2'
WHEN 'O' THEN '4'
ELSE NULL END) AS ABOGROUP,
(SELECT CASE (pt.bloodgroup_rh) 
WHEN '+' THEN '1'
WHEN '-' THEN '2'
WHEN 'Positive' THEN '1'
WHEN 'Negative' THEN '2'
WHEN 'positive' THEN '1'
WHEN 'negative' THEN '2'
WHEN 'pos' THEN '1'
WHEN 'neg' THEN '2'
WHEN 'p' THEN '1'
WHEN 'n' THEN '2'
ELSE NULL END) AS RHGROUP,
IF((SELECT regiment_type FROM patient_regiment pr WHERE pr.hn=pt.hn)= '13','23',NULL) AS LABOR,
pt.passport_no AS PASSPORT,
IFNULL(pt.type_area,'4') AS TYPEAREA, 
IF(pt.last_update IS NULL OR TRIM(pt.last_update )='' OR pt.last_update LIKE '0000-00-00%','',DATE_FORMAT(pt.last_update ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
pt.hometel AS TELEPHONE,
pt.informtel AS MOBILE

FROM patient pt
LEFT JOIN pname pn ON pt.pname=pn.name
LEFT JOIN provis_pname pn2 ON pt.pname = pn2.provis_pname_short_name
LEFT JOIN vn_stat v ON v.hn = pt.hn
WHERE (pt.cid <> '' AND pt.cid IS NOT NULL 
AND pt.cid NOT IN (SELECT cid FROM person))
AND (v.vstdate BETWEEN 20180110 AND 20180110
OR pt.last_update BETWEEN 20180110 AND 20180110)

