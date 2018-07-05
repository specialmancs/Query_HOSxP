SELECT DISTINCT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,pt.hn) AS PID,
(SELECT CASE 
WHEN pl.death_place = "1" THEN (SELECT hospitalcode FROM opdconfig)
ELSE "00000" END)AS HOSPDEATH,
pl.an AS AN,
IFNULL(v.vn,v.lastvisit_vn) AS SEQ ,
IF(pl.death_date IS NULL OR TRIM(pl.death_date)='' OR pl.death_date LIKE '0000-00-00%','',DATE_FORMAT(pl.death_date,'%Y%m%d')) AS DDEATH,
pl.death_diag_1 AS CDEATH_A ,
pl.death_diag_2 AS CDEATH_B,
pl.death_diag_3 AS CDEATH_C,
pl.death_diag_4 AS CDEATH_D,
pl.odisease AS ODISEASE,
pl.death_cause AS CDEATH,  
(SELECT CASE 
WHEN pl.nopreg='Y' AND p.sex='2' THEN '1'
WHEN pl.nopreg='N' AND p.sex='2' THEN '9'
ELSE NULL END) AS PREGDEATH,
pl.death_place AS PDEATH,
(SELECT cid FROM doctor WHERE pl.death_cert_doctor = `code`) AS PROVIDER,
IF(pl.last_update IS NULL OR TRIM(pl.last_update)='' OR pl.last_update LIKE '0000-00-00%','',DATE_FORMAT(pl.last_update,'%Y%m%d%H%i%s')) AS D_UPDATE,
IF(p.cid IS NOT NULL OR p.cid <> '',p.cid,pt.cid) AS CID,
IFNULL(p.patient_hn,pt.hn) as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge
FROM death pl 
LEFT OUTER JOIN person p ON p.patient_hn = pl.hn 
LEFT OUTER JOIN patient pt ON pt.hn = pl.hn 
LEFT OUTER JOIN vn_stat v on v.hn = pl.hn and v.vstdate = pl.death_date
WHERE pt.cid<>'' 
AND pt.cid IS NOT NULL 
AND pl.death_date IS NOT NULL
AND pl.death_date Between 20160701 AND 20160731
GROUP BY pt.cid

UNION ALL
SELECT DISTINCT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,pt.hn) AS PID,
(SELECT CASE 
WHEN pl.death_place = "1" THEN (SELECT hospitalcode FROM opdconfig)
ELSE "00000" END)AS HOSPDEATH,
'' AS AN,
IFNULL(v.vn,v.lastvisit_vn) AS SEQ ,
IF(pl.death_date IS NULL OR TRIM(pl.death_date)='' OR pl.death_date LIKE '0000-00-00%','',DATE_FORMAT(pl.death_date,'%Y%m%d')) AS DDEATH,
pl.death_diag_1 AS CDEATH_A ,
pl.death_diag_2 AS CDEATH_B,
pl.death_diag_3 AS CDEATH_C,
pl.death_diag_4 AS CDEATH_D,
pl.odisease AS ODISEASE,
pl.death_cause AS CDEATH,
(SELECT CASE 
WHEN pl.nopreg='Y' AND p.sex='2' THEN '1'
WHEN pl.nopreg='N' AND p.sex='2' THEN '9'
ELSE NULL END) AS PREGDEATH,
pl.death_place AS PDEATH, 
(SELECT cid FROM doctor WHERE pl.death_cert_doctor = `code`) AS PROVIDER, 
IF(pl.last_update IS NULL OR TRIM(pl.last_update)='' OR pl.last_update LIKE '0000-00-00%','',DATE_FORMAT(pl.last_update,'%Y%m%d%H%i%s')) AS D_UPDATE,
IF(p.cid IS NOT NULL OR p.cid <> '',p.cid,pt.cid) AS CID,
IFNULL(p.patient_hn,pt.hn) as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_death pl
LEFT OUTER JOIN person p ON p.person_id = pl.person_id 
LEFT OUTER JOIN patient pt ON pt.hn = p.patient_hn 
LEFT OUTER JOIN vn_stat v on  pl.death_date = v.vstdate AND p.patient_hn = v.hn

WHERE pt.cid<>'' AND pt.cid IS NOT NULL AND pl.death_date IS NOT NULL
AND pt.hn NOT IN (SELECT hn FROM death WHERE pt.hn = death.hn)
AND pl.death_date Between 20160701 AND 20160731

GROUP BY pt.cid
