SELECT DISTINCT
(SELECT opdconfig.hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(pe.person_id,pt.hn) AS PID,
IF(oe.report_date IS NULL OR TRIM(oe.report_date)=' ' OR oe.report_date LIKE '0000-00-00%','',DATE_FORMAT(oe.report_date,'%Y%m%d')) AS DATERECORD,

oe.agent_code24  AS DRUGALLERGY,
oe.agent AS DNAME,

(SELECT CASE
WHEN oe.allergy_relation_id IN ('1','2','3','4','5') THEN oe.allergy_relation_id
ELSE "1" END) AS TYPEDX,
oe.seriousness_id AS ALEVEL,
oe.opd_allergy_symtom_type_id AS SYMPTOM,
'' AS INFORMANT,
(SELECT DISTINCT opdconfig.hospitalcode FROM opdconfig) AS INFORMHOSP,
If(oe.update_datetime IS NULL OR TRIM(oe.update_datetime) = '' OR oe.update_datetime LIKE '0000-00-00%', '', DATE_FORMAT(oe.update_datetime,'%Y%m%d%H%i%s')) AS D_UPDATE,
pt.cid AS CID,
IFNULL(pe.patient_hn,pt.hn) as HN,
concat(pe.pname,pe.fname," ",pe.lname) as ptname,
IFNULL(pe.house_regist_type_id,pt.type_area) as typearea,
pe.person_discharge_id as discharge
FROM opd_allergy  oe
LEFT JOIN patient pt ON oe.hn=pt.hn
LEFT OUTER JOIN person pe ON oe.hn = pe.patient_hn AND pt.hn = pe.patient_hn AND pt.cid = pe.cid
WHERE oe.report_date Between 20160701 AND 20160731
