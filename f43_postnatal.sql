SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,  
p.person_id AS PID,
ppc.vn AS SEQ,
pa.preg_no  AS GRAVIDA,
IF(pa.labor_date IS NULL OR TRIM(pa.labor_date)='' OR pa.labor_date LIKE '0000-00-00%','',DATE_FORMAT(pa.labor_date,'%Y%m%d')) AS BDATE,
IF(ppc.care_date IS NULL OR TRIM(ppc.care_date)='' OR ppc.care_date LIKE '0000-00-00%','',DATE_FORMAT(ppc.care_date,'%Y%m%d')) AS PPCARE,
(SELECT hospitalcode FROM opdconfig) AS PPPLACE,
(SELECT CASE ppc.uterus_level_normal
WHEN 'Y' THEN '1'
WHEN 'N' THEN '0'
ELSE '9'  END )AS PPRESULT, 
doctor.cid AS PROVIDER,
IF(pa.last_update IS NULL OR TRIM(pa.last_update)='' OR pa.last_update LIKE '0000-00-00%','',DATE_FORMAT(pa.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_anc_preg_care ppc
LEFT OUTER JOIN person_anc pa ON ppc.person_anc_id = pa.person_anc_id
LEFT OUTER JOIN person p ON p.person_id = pa.person_id
LEFT JOIN doctor ON pa.anc_register_staff = doctor.`name`
where pa.last_update between 20160401 and 20160431
/*WHERE DATE_FORMAT(pa.labor_date,'%Y%m') = '201402'*/

/* Edited by TAKIS 28/9/2557*/