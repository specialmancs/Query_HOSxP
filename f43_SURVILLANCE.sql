SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IF(p.person_id IS NULL,vn.hn,p.person_id) AS PID,
sr.vn AS SEQ,
IF(sr.vstdate IS NULL OR TRIM(sr.vstdate)='' OR sr.vstdate  LIKE '0000-00-00%','',DATE_FORMAT(sr.vstdate,'%Y%m%d')) AS DATE_SERV,
'' AS AN,
'' AS DATETIME_ADMIT,
(SELECT CASE 
WHEN sr.code506 = '2' THEN '0001'
WHEN sr.code506 = '3' THEN '0002'
WHEN sr.code506 = '18' THEN '0003'
WHEN sr.code506 IN ('5','6') THEN '0004'
WHEN sr.pdx = 'B34' THEN '0005'
WHEN sr.code506 IN ('96','13','70') THEN '0006'
WHEN sr.code506 = '14' THEN '0007'
WHEN sr.pdx = 'R21' THEN '0008'
WHEN sr.pdx = '15' THEN '0009'
END) AS SYNDROME,
IF (vn.pdx IS NULL OR vn.pdx = ' ',sr.pdx,vn.pdx) AS DIAGCODE,
sr.code506 AS CODE506,
vn.dx0 AS DIAGCODELAST,
sr.pdx AS CODE506LAST,
IF(sr.begin_date IS NULL OR TRIM(sr.begin_date)='' OR sr.begin_date  LIKE '0000-00-00%','',DATE_FORMAT(sr.begin_date,'%Y%m%d')) AS ILLDATE,
sr.addr AS ILLHOUSE,
sr.moo  AS ILLVILLAGE,
sr.tmbpart AS ILLTAMBON,
sr.amppart AS ILLAMPUR,
sr.chwpart AS ILLCHANGWAT,
h.latitude AS LATITUDE,
h.LONGITUDE AS LONGITUDE,
(SELECT CASE 
WHEN sr.ptstat = '1' THEN '1'
WHEN sr.ptstat = '2' THEN '2'
WHEN sr.ptstat = '3' THEN '3'
WHEN sr.ptstat = '4'THEN '9'
END) AS PTSTATUS,
IF(sr.death_date  IS NULL OR TRIM(sr.death_date )='' OR sr.death_date  LIKE '0000-00-00%','',DATE_FORMAT(sr.death_date ,'%Y%m%d') ) AS DATE_DEATH,
sr.complication AS COMPLICATION,
sr.organism AS ORGANISM,
(SELECT cid FROM doctor WHERE vn.dx_doctor = `code`) AS PROVIDER,
IF(sr.last_update  IS NULL OR TRIM(sr.last_update )='' OR sr.last_update  LIKE '0000-00-00%','',DATE_FORMAT(sr.last_update ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
pt.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM surveil_member sr
LEFT JOIN vn_stat vn ON  sr.vn = vn.vn AND sr.hn = vn.hn 
LEFT JOIN patient pt ON sr.hn=pt.hn
LEFT JOIN code506 c5 ON sr.pdx=c5.`code`
LEFT OUTER JOIN person p ON p.cid=pt.cid 
LEFT OUTER JOIN house h ON h.house_id=p.house_id

WHERE (sr.vn IS NOT NULL OR sr.vn <> '') 
AND p.person_id  IS NOT NULL 
AND vn.pdx IS NOT NULL
AND sr.vn not in (select vn from an_stat)
AND sr.begin_date BETWEEN 20160601 AND 20160630



UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IF(p.person_id IS NULL,an.hn,p.person_id) AS PID,
sr.vn AS SEQ,
IF(sr.vstdate IS NULL OR TRIM(sr.vstdate)='' OR sr.vstdate  LIKE '0000-00-00%','',DATE_FORMAT(sr.vstdate,'%Y%m%d')) AS DATE_SERV,
an.an AS AN,
IF(an.regdate IS NULL OR TRIM(an.regdate)='' OR an.regdate LIKE '0000-00-00%','',DATE_FORMAT(an.regdate,'%Y%m%d%H%i%s') ) AS DATETIME_ADMIT,
(SELECT CASE 
WHEN sr.code506 = '2' THEN '0001'
WHEN sr.code506 = '3' THEN '0002'
WHEN sr.code506 = '18' THEN '0003'
WHEN sr.code506 IN ('5','6') THEN '0004'
WHEN sr.pdx = 'B34' THEN '0005'
WHEN sr.code506 IN ('96','13','70') THEN '0006'
WHEN sr.code506 = '14' THEN '0007'
WHEN sr.pdx = 'R21' THEN '0008'
WHEN sr.pdx = '15' THEN '0009'
END) AS SYNDROME,
an.pdx AS DIAGCODE,
sr.code506 AS CODE506,
an.dx0 AS DIAGCODELAST,
sr.pdx AS CODE506LAST,
IF(sr.begin_date IS NULL OR TRIM(sr.begin_date)='' OR sr.begin_date  LIKE '0000-00-00%','',DATE_FORMAT(sr.begin_date,'%Y%m%d')) AS ILLDATE,
sr.addr AS ILLHOUSE,
sr.moo  AS ILLVILLAGE,
sr.tmbpart  AS ILLTAMBON,
sr.amppart  AS ILLAMPUR,
sr.chwpart  AS ILLCHANGWAT,
h.latitude  AS LATITUDE,
h.LONGITUDE AS LONGITUDE,
(SELECT CASE 
WHEN sr.ptstat = '1' THEN '1'
WHEN sr.ptstat = '2' THEN '2'
WHEN sr.ptstat = '3' THEN '3'
WHEN sr.ptstat = '4'THEN '9'
END) AS PTSTATUS,
IF(sr.death_date  IS NULL OR TRIM(sr.death_date )='' OR sr.death_date  LIKE '0000-00-00%','',DATE_FORMAT(sr.death_date ,'%Y%m%d') ) AS DATE_DEATH,
sr.complication AS COMPLICATION,
sr.organism AS ORGANISM,
(SELECT cid FROM doctor WHERE an.dx_doctor = `code`) AS PROVIDER,
IF(sr.last_update  IS NULL OR TRIM(sr.last_update )='' OR sr.last_update  LIKE '0000-00-00%','',DATE_FORMAT(sr.last_update ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
pt.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM surveil_member sr
LEFT JOIN an_stat an ON  sr.vn = an.vn AND sr.hn = an.hn 
LEFT JOIN patient pt ON sr.hn=pt.hn
LEFT JOIN code506 c5 ON sr.pdx=c5.`code`
LEFT OUTER JOIN person p ON p.cid=pt.cid 
LEFT OUTER JOIN house h ON h.house_id=p.house_id

WHERE (sr.vn IS NOT NULL OR sr.vn <> '') 
AND p.person_id  IS NOT NULL 
AND an.pdx IS NOT NULL
#AND sr.vn not in (select vn from vn_stat)
AND sr.begin_date BETWEEN 20160601 AND 20160630

GROUP BY SEQ