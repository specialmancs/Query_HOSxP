SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,	
e5.person_id AS PID,
e3.vn AS SEQ,
IF(e3.vaccine_date IS NULL OR TRIM(e3.vaccine_date)='' OR e3.vaccine_date LIKE '0000-00-00%','',DATE_FORMAT(e3.vaccine_date,'%Y%m%d') ) AS DATE_SERV,
e1.export_vaccine_code AS VACCINETYPE,
(SELECT hospitalcode FROM opdconfig)  AS VACCINEPLACE,
dc.cid AS PROVIDER,
IF(e4.last_update IS NULL OR TRIM(e4.last_update)='' OR e4.last_update LIKE '0000-00-00%','',DATE_FORMAT(e4.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
e5.cid AS CID,
e5.patient_hn as HN,
concat(e5.pname,e5.fname," ",e5.lname) as ptname,
e5.house_regist_type_id as typearea,
e5.person_discharge_id as discharge

FROM epi_vaccine e1 
LEFT JOIN person_epi_vaccine_list e2 ON e1.epi_vaccine_id = e2.epi_vaccine_id 
LEFT OUTER JOIN person_epi_vaccine e3  ON e2.person_epi_vaccine_id = e3.person_epi_vaccine_id 
LEFT OUTER JOIN person_epi e4 ON e3.person_epi_id = e4.person_epi_id  
LEFT OUTER JOIN person e5 ON e4.person_id = e5.person_id
LEFT OUTER JOIN doctor dc ON dc.`code` = e2.doctor_code

WHERE e5.cid IS NOT NULL
AND e3.vaccine_date BETWEEN 20160501 AND 20160530

UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
v5.person_id AS PID,
v3.vn AS SEQ,
IF(v3.vaccine_date IS NULL OR TRIM(v3.vaccine_date)='' OR v3.vaccine_date LIKE '0000-00-00%','',DATE_FORMAT(v3.vaccine_date,'%Y%m%d') ) AS DATE_SERV,
v2.export_vaccine_code AS VACCINETYPE,
(SELECT hospitalcode FROM opdconfig)  AS VACCINEPLACE,
dc.cid AS PROVIDER,
IF(v4.last_update IS NULL OR TRIM(v4.last_update)='' OR v4.last_update LIKE '0000-00-00%','',DATE_FORMAT(v4.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
v5.cid AS CID,
v5.patient_hn as HN,
concat(v5.pname,v5.fname," ",v5.lname) as ptname,
v5.house_regist_type_id as typearea,
v5.person_discharge_id as discharge

FROM  village_student_vaccine_list v1
LEFT JOIN student_vaccine v2 ON v1.student_vaccine_id = v2.student_vaccine_id   
LEFT JOIN village_student_vaccine v3 ON v1.village_student_vaccine_id = v3.village_student_vaccine_id
LEFT OUTER JOIN village_student v4 ON  v3.village_student_id = v4.village_student_id 
LEFT OUTER JOIN person v5 ON v4.person_id = v5.person_id 
LEFT OUTER JOIN doctor dc ON dc.`code` = v1.doctor_code

WHERE v5.cid IS NOT NULL
AND v3.vaccine_date BETWEEN 20160501 AND 20160530

UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p4.person_id AS PID,
p2.vn AS SEQ,
IF(p2.anc_service_date IS NULL OR TRIM(p2.anc_service_date)='' OR p2.anc_service_date LIKE '0000-00-00%','',DATE_FORMAT(p2.anc_service_date,'%Y%m%d') ) AS DATE_SERV,
a1.export_vaccine_code AS VACCINETYPE,
(SELECT hospitalcode FROM opdconfig) AS VACCINEPLACE,
dc.cid AS PROVIDER,
IF(p3.last_update  IS NULL OR TRIM(p3.last_update)='' OR p3.last_update LIKE '0000-00-00%','',DATE_FORMAT(p3.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p4.cid AS CID,
p4.patient_hn as HN,
concat(p4.pname,p4.fname," ",p4.lname) as ptname,
p4.house_regist_type_id as typearea,
p4.person_discharge_id as discharge

FROM person_anc_service_detail p1
LEFT JOIN anc_service a1 ON p1.anc_service_id = a1.anc_service_id 
LEFT JOIN person_anc_service p2 ON p1.person_anc_service_id = p2.person_anc_service_id
LEFT OUTER JOIN person_anc p3 ON p2.person_anc_id = p3.person_anc_id 
LEFT OUTER JOIN person p4 ON p3.person_id = p4.person_id
LEFT OUTER JOIN doctor dc ON dc.`code` = p2.provider_hospcode

WHERE p4.cid IS NOT NULL
AND p2.anc_service_date BETWEEN 20160501 AND 20160530

UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
w5.person_id AS PID,
w3.vn AS SEQ,
IF(w3.service_date IS NULL OR TRIM(w3.service_date)='' OR w3.service_date LIKE '0000-00-00%','',DATE_FORMAT(w3.service_date,'%Y%m%d') ) AS DATE_SERV,
w2.export_vaccine_code AS VACCINETYPE,
(SELECT hospitalcode FROM opdconfig)  AS VACCINEPLACE,
dc.cid AS PROVIDER,
IF(w4.last_update  IS NULL OR TRIM(w4.last_update)='' OR w4.last_update LIKE '0000-00-00%','',DATE_FORMAT(w4.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
w5.cid AS CID,
w5.patient_hn as HN,
concat(w5.pname,w5.fname," ",w5.lname) as ptname,
w5.house_regist_type_id as typearea,
w5.person_discharge_id as discharge

FROM person_wbc_vaccine_detail w1
LEFT JOIN wbc_vaccine w2 ON w1.wbc_vaccine_id = w2.wbc_vaccine_id
LEFT JOIN person_wbc_service w3 ON w1.person_wbc_service_id = w3.person_wbc_service_id
LEFT OUTER JOIN person_wbc w4 ON w3.person_wbc_id = w4.person_wbc_id
LEFT OUTER JOIN person w5 ON w4.person_id = w5.person_id 
LEFT OUTER JOIN doctor dc ON dc.`code` = w1.doctor_code

WHERE w5.cid IS NOT NULL 
AND w3.service_date BETWEEN 20160501 AND 20160530
UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,	
pw.person_id AS PID,
pv.vn AS SEQ,
IF(pw.vaccine_date IS NULL OR TRIM(pw.vaccine_date)='' OR pw.vaccine_date LIKE '0000-00-00%','',DATE_FORMAT(pw.vaccine_date,'%Y%m%d') ) AS DATE_SERV,
(SELECT pv.export_vaccine_code FROM person_vaccine pv WHERE pw.person_vaccine_id=pv.person_vaccine_id ) AS VACCINETYPE,
pw.hospcode AS VACCINEPLACE,
'' AS PROVIDER,
IF(pw.update_datetime IS NULL OR TRIM(pw.update_datetime)='' OR pw.update_datetime LIKE '0000-00-00%','',DATE_FORMAT(pw.update_datetime,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_vaccine_elsewhere pw
LEFT JOIN person_epi_vaccine pv ON pw.person_vaccine_id=pv.person_epi_id
LEFT JOIN person p ON pw.person_id = p.person_id


WHERE p.cid IS NOT NULL
AND pw.vaccine_date BETWEEN 20160501 AND 20160530

UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IF(p.person_id IS NULL OR p.person_id="0",o.hn,p.person_id) AS PID,
#p.person_id as PID,
ov.vn AS SEQ,
IF(o.vstdate IS NULL OR TRIM(o.vstdate)='' OR o.vstdate LIKE '0000-00-00%','',DATE_FORMAT(o.vstdate,'%Y%m%d') ) AS DATE_SERV,
pv.export_vaccine_code AS VACCINETYPE,
(SELECT hospitalcode FROM opdconfig) AS VACCINEPLACE,
dc.cid AS PROVIDER,
IF(o.vstdate IS NULL OR TRIM(o.vstdate)='' OR o.vstdate LIKE '0000-00-00%','',DATE_FORMAT(o.vstdate,'%Y%m%d') ) AS D_UPDATE,
IF(p.cid IS NULL,pt.cid,p.cid) AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM ovst_vaccine ov
LEFT OUTER JOIN person_vaccine pv on pv.person_vaccine_id = ov.person_vaccine_id
LEFT OUTER JOIN ovst o on o.vn = ov.vn
LEFT OUTER JOIN patient pt on pt.hn = o.hn
LEFT OUTER JOIN person p on p.cid = pt.cid
LEFT OUTER JOIN opduser us on us.loginname = ov.staff
LEFT OUTER JOIN doctor dc on us.`name` = dc.`name`

WHERE o.vstdate BETWEEN 20160501 AND 20160530


#BETWEEN :date_start_text AND :date_end_text

