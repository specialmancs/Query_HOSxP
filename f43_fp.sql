SELECT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,	
w.person_id AS PID,
pw.vn AS SEQ,	
IF(pw.service_date IS NULL OR TRIM(pw.service_date)='' OR pw.service_date LIKE '0000-00-00%','',DATE_FORMAT(pw.service_date,'%Y%m%d') ) AS DATE_SERV,
wb2.export_code AS FPTYPE,
(SELECT hospitalcode FROM opdconfig) AS FPPLACE,
#(SELECT cid FROM doctor WHERE w.doctor_code  = `code`)AS PROVIDER,
dc.cid AS PROVIDER,
IF(w.last_update IS NULL OR TRIM(w.last_update)='' OR w.last_update LIKE '0000-00-00%','',DATE_FORMAT(w.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_women_service pw 
LEFT OUTER JOIN person_women w ON pw.person_women_id = w.person_women_id 
LEFT OUTER JOIN opitemrece opi ON pw.vn = opi.vn
JOIN drugitems d ON d.icode=opi.icode
LEFT OUTER JOIN person p ON p.person_id=w.person_id
LEFT OUTER JOIN women_birth_control wb1 ON wb1.women_birth_control_id = w.women_birth_control_id 
LEFT OUTER JOIN women_birth_control wb2 on wb2.women_birth_control_id = pw.women_birth_control_id 
LEFT OUTER JOIN doctor dc on  pw.doctor_code = dc.`code`

WHERE pw.women_birth_control_id IS NOT NULL   
AND pw.women_birth_control_id <>'' 
AND w.last_update IS NOT NULL AND wb2.export_code <> '0'
AND pw.vn IS NOT NULL 
AND pw.women_service_id = 1 
AND d.fp_drug='Y'
AND pw.service_date BETWEEN 20160401 AND 20160431
GROUP BY pw.vn

UNION ALL
SELECT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p.person_id AS PID,	
pw.vn AS SEQ,
IF(a.last_update IS NULL OR TRIM(a.last_update)='' OR a.last_update LIKE '0000-00-00%','',DATE_FORMAT(a.last_update,'%Y%m%d') ) AS DATE_SERV,
w.export_code AS FPTYPE,
(SELECT hospitalcode FROM opdconfig) AS FPPLACE,
#(SELECT cid FROM doctor WHERE opi.doctor = `code`)AS PROVIDER,
dc.cid AS PROVIDER,
IF(a.last_update IS NULL OR TRIM(a.last_update)='' OR a.last_update LIKE '0000-00-00%','',DATE_FORMAT(a.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge
 
FROM person_women a  
LEFT OUTER JOIN person p ON p.person_id = a.person_id  
LEFT OUTER JOIN house h ON h.house_id = p.house_id  
LEFT OUTER JOIN village v ON v.village_id = p.village_id  
LEFT OUTER JOIN thaiaddress t ON t.addressid = v.address_id  
LEFT OUTER JOIN marrystatus m ON m.code = p.marrystatus  
LEFT OUTER JOIN women_birth_control w ON w.women_birth_control_id = a.women_birth_control_id
LEFT OUTER JOIN person_women_service pw on pw.person_women_id = a.person_women_id 
LEFT OUTER JOIN opitemrece opi ON pw.vn=opi.vn 
LEFT OUTER JOIN doctor dc on  pw.doctor_code = dc.`code`

WHERE (a.discharge <> 'Y' OR a.discharge IS NULL)  AND (a.women_birth_control_id <> '' OR a.women_birth_control_id IS NOT NULL)
AND a.last_update BETWEEN 20160401 AND 20160431
GROUP BY pw.vn
/*Design By TAKIS TEAM 17/06/2557*/