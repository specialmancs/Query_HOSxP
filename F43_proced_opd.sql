SET @d = 20171001;
SET @e = 20180930;

SELECT t.PROCEDCODE FROM (
#thaimed
SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,o.hn) AS PID,
o.vn AS SEQ,
IF(o.vstdate IS NULL OR TRIM(o.vstdate)='' OR o.vstdate LIKE '0000-00-00%','',DATE_FORMAT(o.vstdate,'%Y%m%d')) AS DATE_SERV,
sp.provis_code AS CLINIC,
CONCAT(h4.health_med_organ_code,h6.health_med_operation_type_code,h3.health_med_operation_item_code) AS PROCEDCODE,
IF(h2 .service_price  IS NOT NULL AND TRIM(h2 .service_price )<>'', REPLACE(FORMAT(h2 .service_price ,2),',',''), FORMAT(0,2)) AS  SERVICEPRICE,
h7.cid AS PROVIDER,
IF(CONCAT(o.vstdate,' ',o.vsttime) IS NULL OR TRIM(CONCAT(o.vstdate,' ',o.vsttime))='' OR CONCAT(o.vstdate,' ',o.vsttime)  LIKE "0000-00-00%",'',DATE_FORMAT(CONCAT(o.vstdate,' ',o.vsttime) ,"%Y%m%d%H%i%s") ) AS D_UPDATE,
v.cid AS CID
FROM health_med_service h1 
INNER JOIN health_med_service_operation h2 ON h2.health_med_service_id = h1.health_med_service_id 
INNER JOIN health_med_operation_item h3 ON h3.health_med_operation_item_id = h2.health_med_operation_item_id 
INNER JOIN health_med_organ h4 ON h4.health_med_organ_id = h2.health_med_organ_id 
INNER JOIN health_med_operation_item_organ h5 ON h5.health_med_operation_item_id = h3.health_med_operation_item_id
INNER JOIN health_med_operation_type h6 ON h6.health_med_operation_type_id = h2.health_med_operation_type_id 
LEFT JOIN  health_med_provider h7 ON h7.health_med_provider_id = h2.health_med_provider_id
INNER JOIN ovst o ON o.vn = h1.vn AND h1.hn=o.hn
INNER JOIN vn_stat v ON v.vn = h1.vn AND h1.hn=v.hn
LEFT  JOIN person p ON p.patient_hn=o.hn
INNER JOIN spclty sp ON sp.spclty = o.spclty
WHERE h3.health_med_operation_item_code <> '' AND h3.health_med_operation_item_code IS NOT NULL
AND o.vstdate BETWEEN @d AND @e

UNION ALL
#dental
SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,o.hn) AS PID,
v.vn AS SEQ,
IF(d.vstdate IS NULL OR TRIM(d.vstdate)='' OR d.vstdate LIKE '0000-00-00%','',DATE_FORMAT(d.vstdate,'%Y%m%d')) AS DATE_SERV,
sp.provis_code AS CLINIC, 
IF(t.icd10tm_operation_code IS NULL OR t.icd10tm_operation_code= '',t.icd9cm,t.icd10tm_operation_code) AS PROCEDCODE,
IF( d.fee  IS NOT NULL AND TRIM( d.fee )<>'', REPLACE(FORMAT( d.fee ,2),',',''), FORMAT(0,2)) AS  SERVICEPRICE,
(SELECT cid FROM doctor WHERE d.doctor = `code`) AS PROVIDER,
IF( concat(o.vstdate,'',o.vsttime) IS NULL OR TRIM(concat(o.vstdate,'',o.vsttime))='' OR concat(o.vstdate,'',o.vsttime) LIKE '0000-00-00%','',DATE_FORMAT(concat(o.vstdate,' ',o.vsttime) ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
v.cid AS CID
FROM dtmain d 
LEFT JOIN person p ON p.patient_hn = d.hn
INNER JOIN dttm t ON t.icd9cm = d.icd9 AND d.tmcode = t.code /*edited date: 1/11/2557*/
INNER JOIN vn_stat v ON v.vn = d.vn AND v.hn = d.hn
INNER JOIN ovst o ON o.vn = d.vn AND o.hn = d.hn
INNER JOIN spclty sp ON sp.spclty = o.spclty 
WHERE t.icd10tm_operation_code <> '' AND t.icd10tm_operation_code IS NOT NULL
AND d.vstdate BETWEEN @d AND @e

UNION ALL
#er
SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,o.hn) AS PID,
v.vn AS SEQ,
IF(o.vstdate IS NULL OR TRIM(o.vstdate)='' OR o.vstdate LIKE '0000-00-00%','',DATE_FORMAT(o.vstdate,'%Y%m%d')) AS DATE_SERV,
sp.provis_code AS CLINIC,
IF(e.icd10tm IS NULL OR e.icd10tm = '',e.icd9cm,e.icd10tm) AS PROCEDCODE,
IF(e.price IS NOT NULL AND TRIM(e.price )<>'', REPLACE(FORMAT(e.price ,2),',',''), FORMAT(0,2)) AS  SERVICEPRICE,
(SELECT cid FROM doctor WHERE r.doctor = `code`) AS PROVIDER,
IF( concat(o.vstdate,'',o.vsttime) IS NULL OR TRIM(concat(o.vstdate,' ',o.vsttime))='' OR concat(o.vstdate,' ',o.vsttime) LIKE '0000-00-00%','',DATE_FORMAT(concat(o.vstdate,' ',o.vsttime) ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
v.cid AS CID
FROM er_regist_oper r 
LEFT OUTER JOIN er_oper_code e ON e.er_oper_code=r.er_oper_code
LEFT OUTER JOIN vn_stat v ON v.vn=r.vn 
LEFT OUTER JOIN ovst o ON o.vn=r.vn
LEFT OUTER JOIN person p ON p.patient_hn=o.hn
LEFT OUTER JOIN spclty sp ON sp.spclty = o.spclty 
WHERE e.icd9cm <>'' AND e.icd9cm IS NOT NULL
AND o.vstdate BETWEEN @d AND @e
/*AND DATE_FORMAT(o.vstdate,'%Y%m%d') BETWEEN '20141001' AND '20150930'*/

UNION ALL

#operation
SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,o.hn) AS PID,
doe.vn AS SEQ,
IF(o.vstdate IS NULL OR TRIM(o.vstdate)='' OR o.vstdate LIKE '0000-00-00%','',DATE_FORMAT(o.vstdate,'%Y%m%d')) AS DATE_SERV,
sp.provis_code AS CLINIC,
eo.icd10tm AS PROCEDCODE,
IF(doe.price  IS NOT NULL AND TRIM(doe.price)<>'', REPLACE(FORMAT(doe.price,2),',',''), FORMAT(0,2)) AS  SERVICEPRICE,
(SELECT cid FROM doctor WHERE doe.doctor = `code`) AS PROVIDER,
IF(CONCAT(o.vstdate,' ',o.vsttime) IS NULL OR TRIM(CONCAT(o.vstdate,' ',o.vsttime))='' OR CONCAT(o.vstdate,' ',o.vsttime)  LIKE "0000-00-00%",'',DATE_FORMAT(CONCAT(o.vstdate,' ',o.vsttime) ,"%Y%m%d%H%i%s") ) AS D_UPDATE,
v.cid AS CID
FROM doctor_operation  doe
LEFT OUTER JOIN ovst o ON o.vn = doe.vn 
LEFT OUTER JOIN vn_stat v ON v.vn = doe.vn 
LEFT OUTER JOIN person p ON p.patient_hn=o.hn
LEFT OUTER JOIN spclty sp ON sp.spclty = o.spclty
LEFT OUTER JOIN er_oper_code eo ON eo.er_oper_code = doe.er_oper_code
WHERE eo.icd10tm IS NOT NULL AND eo.icd10tm  <> ''
AND o.vstdate BETWEEN @d AND @e
/*AND DATE_FORMAT(o.vstdate,'%Y%m%d') BETWEEN '20141001' AND '20150930'*/
GROUP BY doe.doctor_operation_id
/*Edited date : 29/10/2557*/
)t
WHERE t.PROCEDCODE LIKE '9007%'
GROUP BY t.PROCEDCODE