SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,	
pd.deformed_no AS DISABID,
pd.person_id AS PID,
dd.deformed_id AS DISABTYPE,
dd.person_deformed_cause_type_id AS DISABCAUSE,
dd.icd10 AS DIAGCODE,
IF(pd.register_date IS NULL OR TRIM(pd.register_date)='' OR pd.register_date LIKE '0000-00-00%','',DATE_FORMAT(pd.register_date,'%Y%m%d') ) AS DATE_DETECT,
IF(dd.deformed_date IS NULL OR TRIM(dd.deformed_date)='' OR dd.deformed_date LIKE '0000-00-00%','',DATE_FORMAT(dd.deformed_date,'%Y%m%d') ) AS DATE_DISAB,
IF(dd.entry_datetime IS NULL OR TRIM(dd.entry_datetime)='' OR dd.entry_datetime LIKE '0000-00-00%','',DATE_FORMAT(dd.entry_datetime,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_deformed  pd
LEFT OUTER JOIN person_deformed_detail dd ON pd.person_deformed_id = dd.person_deformed_id
LEFT OUTER JOIN person p ON p.person_id = pd.person_id
WHERE pd.register_date BETWEEN 20151001 AND 20160930

UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,	
pr.physic_main_regist_id AS DISABID,
IF(p.person_id IS NULL OR p.person_id ='',pt.hn,p.person_id) AS PID,
'' AS DISABTYPE,
'' AS DISABCAUSE,
'' AS DIAGCODE,
IF(pr.physic_main_regist_date IS NULL OR TRIM(pr.physic_main_regist_date)='' OR pr.physic_main_regist_date LIKE '0000-00-00%','',DATE_FORMAT(pr.physic_main_regist_date,'%Y%m%d') ) AS DATE_DETECT,
'' AS DATE_DISAB,
IF(pr.physic_main_regist_lastupdate IS NULL OR TRIM(pr.physic_main_regist_lastupdate)='' OR pr.physic_main_regist_lastupdate LIKE '0000-00-00%','',DATE_FORMAT(pr.physic_main_regist_lastupdate,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM physic_main_regist  pr
LEFT OUTER JOIN patient pt ON pt.hn = pr.hn
LEFT OUTER JOIN person p ON p.patient_hn = pt.hn

WHERE pr.physic_main_regist_date BETWEEN 20151001 AND 20160930