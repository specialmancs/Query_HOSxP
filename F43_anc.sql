SELECT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p.person_id AS PID,a2.vn AS SEQ,
IF(a2.anc_service_date IS NULL OR TRIM(a2.anc_service_date)='' OR a2.anc_service_date LIKE '0000-00-00%','',DATE_FORMAT(a2.anc_service_date,'%Y%m%d') ) AS DATE_SERV, 
a1.preg_no AS GRAVIDA, a2.anc_service_number AS ANCNO,a2.pa_week AS GA,
(SELECT CASE a1.has_risk
WHEN 'Y' THEN '1'
WHEN 'N' THEN '2'
ELSE NULL END)AS ANCRESULT,
(SELECT hospitalcode FROM opdconfig) AS ANCPLACE,
doctor.cid AS PROVIDER,
IF(a1.last_update  IS NULL OR TRIM(a1.last_update )='' OR a1.last_update  LIKE '0000-00-00%','',DATE_FORMAT(a1.last_update ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid as CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_anc a1
LEFT JOIN person_anc_service a2 ON a1.person_anc_id = a2.person_anc_id
LEFT JOIN person p ON a1.person_id = p.person_id
LEFT OUTER JOIN doctor ON a1.anc_register_staff = doctor.`name`
WHERE (a2.anc_service_type_id = 1 OR a2.anc_service_type_id IS NULL) 
#AND a2.anc_service_date BETWEEN :date_start_text AND :date_end_text
AND a2.anc_service_date BETWEEN 20160101 AND 20160131


UNION ALL
SELECT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
pnc.person_id AS PID,
'' AS SEQ,
IF(ano.precare_date IS NULL OR TRIM(ano.precare_date)='' OR ano.precare_date LIKE '0000-00-00%','',DATE_FORMAT(ano.precare_date,'%Y%m%d') ) AS DATE_SERV, 
pnc.preg_no GRAVIDA, 
ano.precare_no AS ANCNO,
a2.pa_week AS GA,
ano.anc_result AS ANCRESULT,
ano.precare_hospcode AS ANCPLACE,
'' AS PROVIDER,
IF(pnc.last_update  IS NULL OR TRIM(pnc.last_update )='' OR pnc.last_update  LIKE '0000-00-00%','',DATE_FORMAT(pnc.last_update ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_anc_other_precare ano
LEFT JOIN person_anc  pnc ON ano.person_anc_id = pnc.person_anc_id
LEFT OUTER JOIN person p ON pnc.person_id = p.person_id
LEFT OUTER JOIN person_anc_service a2 ON ano.precare_date=a2.anc_service_date AND pnc.person_anc_id=a2.person_anc_id
#AND ano.precare_date BETWEEN :date_start_text AND :date_end_text
AND ano.precare_date BETWEEN 20160101 AND 20160131
