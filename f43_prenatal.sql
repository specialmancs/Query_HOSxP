SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
ps.person_id AS PID,
a.preg_no AS GRAVIDA,
IF(a.lmp IS NULL OR TRIM(a.lmp)='' OR a.lmp LIKE '0000-00-00%','',DATE_FORMAT(a.lmp,'%Y%m%d')) AS LMP,
IF(a.edc IS NULL OR TRIM(a.edc)='' OR a.edc LIKE '0000-00-00%','',DATE_FORMAT(a.edc,'%Y%m%d')) AS EDC, 
CASE l1.lab_result_normal IN (SELECT l1.anc_lab_id FROM anc_lab al WHERE l1.anc_lab_id=al.anc_lab_id AND al.anc_lab_code = "VDRL1")
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS VDRL_RESULT, 
CASE l1.lab_result_normal IN (SELECT l1.anc_lab_id FROM anc_lab al WHERE l1.anc_lab_id=al.anc_lab_id AND al.anc_lab_code = "HB")
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS HB_RESULT, 
CASE l1.lab_result_normal IN (SELECT l1.anc_lab_id FROM anc_lab al WHERE l1.anc_lab_id=al.anc_lab_id AND al.anc_lab_code = "HIV1")
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS HIV_RESULT,
IF(a.thalassemia_screen_date IS NULL OR TRIM(a.thalassemia_screen_date)='' OR a.edc LIKE '0000-00-00%','',DATE_FORMAT(a.thalassemia_screen_date,'%Y%m%d'))AS DATE_HCT,
CASE l1.lab_result_normal IN (SELECT l1.anc_lab_id FROM anc_lab al WHERE l1.anc_lab_id=al.anc_lab_id AND al.anc_lab_code = "HCT1")
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS HCT_RESULT,
CASE a.thalasseima_wife_hbtyping_result
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS  THALASSEMIA, 
IF(a.last_update IS NULL OR TRIM(a.last_update)='' OR a.last_update LIKE '0000-00-00%','',DATE_FORMAT(a.last_update,'%Y%m%d%H%i%s'))AS D_UPDATE,
ps.cid AS CID,
ps.patient_hn as HN,
concat(ps.pname,ps.fname," ",ps.lname) as ptname,
ps.house_regist_type_id as typearea,
ps.person_discharge_id as discharge
,a.labor_date
FROM person_anc a
LEFT OUTER JOIN person_anc_service pase ON pase.person_anc_id=a.person_anc_id
LEFT OUTER JOIN person_anc_lab l1 ON pase.person_anc_service_id = l1.person_anc_service_id 
LEFT OUTER JOIN person ps ON ps.person_id = a.person_id 
WHERE (a.discharge <> 'N' OR a.discharge IS NULL) 
AND a.last_update BETWEEN 20161101 AND 20161131
#AND a.last_update BETWEEN :date_start_text AND :date_end_text
GROUP BY a.person_anc_id,a.person_id,a.preg_no

UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
ps.person_id AS PID,
a.preg_no AS GRAVIDA,
IF(a.lmp IS NULL OR TRIM(a.lmp)='' OR a.lmp LIKE '0000-00-00%','',DATE_FORMAT(a.lmp,'%Y%m%d')) AS LMP,
IF(a.edc IS NULL OR TRIM(a.edc)='' OR a.edc LIKE '0000-00-00%','',DATE_FORMAT(a.edc,'%Y%m%d')) AS EDC, 
CASE l1.lab_result_normal IN (SELECT l1.anc_lab_id FROM anc_lab al WHERE l1.anc_lab_id=al.anc_lab_id AND al.anc_lab_code = "VDRL1")
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS VDRL_RESULT, 
CASE l1.lab_result_normal IN (SELECT l1.anc_lab_id FROM anc_lab al WHERE l1.anc_lab_id=al.anc_lab_id AND al.anc_lab_code = "HB")
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS HB_RESULT, 
CASE l1.lab_result_normal IN (SELECT l1.anc_lab_id FROM anc_lab al WHERE l1.anc_lab_id=al.anc_lab_id AND al.anc_lab_code = "HIV1")
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS HIV_RESULT,
IF(a.thalassemia_screen_date IS NULL OR TRIM(a.thalassemia_screen_date)='' OR a.edc LIKE '0000-00-00%','',DATE_FORMAT(a.thalassemia_screen_date,'%Y%m%d'))AS DATE_HCT,
CASE l1.lab_result_normal IN (SELECT l1.anc_lab_id FROM anc_lab al WHERE l1.anc_lab_id=al.anc_lab_id AND al.anc_lab_code = "HCT1")
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS HCT_RESULT,
CASE a.thalasseima_wife_hbtyping_result
		WHEN 'Y' THEN '1'
		WHEN 'N' THEN '2'
		ELSE 9 END AS  THALASSEMIA, 
IF(a.last_update IS NULL OR TRIM(a.last_update)='' OR a.last_update LIKE '0000-00-00%','',DATE_FORMAT(a.last_update,'%Y%m%d%H%i%s'))AS D_UPDATE,
ps.cid AS CID,
ps.patient_hn as HN,
concat(ps.pname,ps.fname," ",ps.lname) as ptname,
ps.house_regist_type_id as typearea,
ps.person_discharge_id as discharge
,a.labor_date
FROM person_anc a
LEFT OUTER JOIN person ps ON ps.person_id = a.person_id

LEFT OUTER JOIN ipt ON ipt.hn = ps.patient_hn
LEFT OUTER JOIN ipt_labour ON ipt_labour.an = ipt.an
LEFT OUTER JOIN ipt_labour_infant ilf ON  ilf.ipt_labour_id = ipt_labour.ipt_labour_id
LEFT OUTER JOIN ipt_pregnancy ip ON ip.an = ipt_labour.an

LEFT OUTER JOIN person_anc_service pase ON pase.person_anc_id=a.person_anc_id
LEFT OUTER JOIN person_anc_lab l1 ON pase.person_anc_service_id = l1.person_anc_service_id 

WHERE ipt.dchdate IS NOT NULL AND ilf.birth_date  BETWEEN 20161101 AND 20161131
OR ipt.dchdate <> '' AND ilf.birth_date  BETWEEN 20161101 AND 20161131
 
#WHERE ilf.birth_date BETWEEN :date_start_text AND :date_end_text
GROUP BY a.person_anc_id,a.person_id,a.preg_no
