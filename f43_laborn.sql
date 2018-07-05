/* From Labor Room */
SELECT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IF(p.person_id IS NOT NULL OR p.person_id <> '',p.person_id,ipt.hn) AS PID,
ipt_labour.g AS GRAVIDA,
IF(ipt_labour.lmp IS NULL OR TRIM(ipt_labour.lmp)='' OR ipt_labour.lmp LIKE '0000-00-00%','',DATE_FORMAT(ipt_labour.lmp,'%Y%m%d') ) AS LMP,
IF(ipt_labour.edc IS NULL OR TRIM(ipt_labour.edc)='' OR ipt_labour.edc LIKE '0000-00-00%','',DATE_FORMAT(ipt_labour.edc,'%Y%m%d') ) AS EDC,
IF(ilf.birth_date IS NULL OR TRIM(ilf.birth_date)='' OR ilf.birth_date LIKE '0000-00-00%','',DATE_FORMAT(ilf.birth_date,'%Y%m%d') )  AS BDATE,
a.pdx AS BRESULT,
ipt_labour.labour_place_id AS BPLACE, 
(SELECT hospitalcode FROM opdconfig) AS BHOSP,
(SELECT 
CASE 
	WHEN deliver_type = 1 THEN 1
	WHEN deliver_type = 3 THEN 6
	WHEN deliver_type = 2 THEN
		CASE
			WHEN deliver_abnormal_type = 0 THEN 2
			WHEN deliver_abnormal_type = 1 THEN 4
			WHEN deliver_abnormal_type = 2 THEN 3
			WHEN deliver_abnormal_type = 3 THEN 5
		ELSE '' END
END
FROM	ipt_pregnancy 
WHERE ipt_pregnancy.an = ipt_labour.an) AS BTYPE,
CASE doctor.position_id
WHEN '1' THEN '1'
WHEN '4' THEN '2'
WHEN '5' THEN '2'
WHEN '6' THEN '3'
ELSE '6' END AS BDOCTOR,
IFNULL((SELECT COUNT(*) from ipt_labour_infant
WHERE ipt_labour_id = ilf.ipt_labour_id
AND infant_dchstts IN ('04','05')
GROUP BY ipt_labour_id),0) AS LBORN,
IFNULL((SELECT COUNT(*) from ipt_labour_infant
WHERE ipt_labour_id = ilf.ipt_labour_id
AND infant_dchstts NOT IN ('04','05')
GROUP BY ipt_labour_id),0) AS SBORN,
IF(CONCAT(ipt.dchdate,' ',ipt.dchtime)IS NULL OR TRIM(CONCAT(ipt.dchdate,' ',ipt.dchtime))=''OR CONCAT(ipt.dchdate,' ',ipt.dchtime)LIKE "0000-00-00%",'',DATE_FORMAT(CONCAT(ipt.dchdate,' ',ipt.dchtime),"%Y%m%d%H%i%s")) AS  D_UPDATE,
IF(patient.cid IS NOT NULL OR patient.cid <> '',patient.cid,p.cid) AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM ipt_labour 
LEFT OUTER JOIN ipt ON ipt.an = ipt_labour.an
LEFT OUTER JOIN ipt_labour_infant ilf ON  ilf.ipt_labour_id = ipt_labour.ipt_labour_id
LEFT OUTER JOIN ipt_pregnancy ip ON ip.an = ipt_labour.an
LEFT OUTER JOIN person p ON p.patient_hn = ipt.hn
LEFT OUTER JOIN patient ON patient.hn=ipt.hn
LEFT OUTER JOIN an_stat a on a.an = ipt_labour.an  
LEFT OUTER JOIN icd101 i1 on i1.code = a.pdx  
LEFT OUTER JOIN icd101 i2 on i2.code = a.dx0 
LEFT OUTER JOIN doctor ON doctor.`code` = ilf.labour_doctor
WHERE ipt.dchdate IS NOT NULL
AND ilf.birth_date  BETWEEN 20160401 AND 20160430 
OR ipt.dchdate <> ''
AND ilf.birth_date  BETWEEN 20160401 AND 20160430
GROUP BY ipt_labour.an
/*Design By TAKIS TEAM 07/03/2558*/

UNION ALL

SELECT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p.person_id AS PID,  
a.preg_no AS GRAVIDA,
IF(a.lmp IS NULL OR TRIM(a.lmp)='' OR a.lmp LIKE '0000-00-00%','',DATE_FORMAT(a.lmp,'%Y%m%d') ) AS LMP,
IF(a.edc IS NULL OR TRIM(a.edc)='' OR a.edc LIKE '0000-00-00%','',DATE_FORMAT(a.edc,'%Y%m%d') ) AS EDC,
DATE_FORMAT(a.labor_date,'%Y%m%y') AS BDATE,
a.labor_icd10 AS BRESULT,
a.labor_place_id AS BPLACE,
a.labour_hospcode AS BHOSP,
a.labour_type_id AS BTYPE,
a.labor_doctor_type_id AS BDOCTOR,
IFNULL(a.alive_child_count,0) AS LBORN,
IFNULL(a.dead_child_count,0) AS SBORN,
IF(a.last_update IS NULL OR TRIM(a.last_update)='' OR a.last_update LIKE '0000-00-00%','',DATE_FORMAT(a.last_update,'%Y%m%d%H%i%s') ) D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_anc a  
LEFT OUTER JOIN person p ON p.person_id = a.person_id  
LEFT OUTER JOIN house h ON h.house_id = p.house_id  
LEFT OUTER JOIN village v ON v.village_id = p.village_id  
LEFT OUTER JOIN labor_status ats ON ats.labor_status_id = a.labor_status_id  
LEFT OUTER JOIN thaiaddress t ON t.addressid = v.address_id  
WHERE (a.discharge <> 'Y' OR a.discharge IS NULL)  
AND ats.labor_status_id IN ('2','3')
AND a.labour_hospcode NOT IN (SELECT hospitalcode FROM opdconfig) 
AND a.labor_date  BETWEEN 20160401 AND 20160430

/*Design By Glison 07/03/2558*/