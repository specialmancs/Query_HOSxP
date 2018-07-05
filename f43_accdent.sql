SELECT  DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE, 
IFNULL(p.person_id,v.hn) AS PID,
v.vn AS SEQ,
IF(er.enter_er_time IS NULL OR TRIM(er.enter_er_time)='' OR er.enter_er_time LIKE '0000-00-00%','',DATE_FORMAT(er.enter_er_time,'%Y%m%d%H%i%s')) AS DATETIME_SERV,
IF(er.enter_er_time IS NULL OR TRIM(er.enter_er_time)='' OR er.enter_er_time LIKE '0000-00-00%','',DATE_FORMAT(er.enter_er_time,'%Y%m%d%H%i%s')) AS DATETIME_AE,
CASE LENGTH(r.er_accident_type_id )
WHEN 1 THEN CONCAT('0',r.er_accident_type_id)
ELSE r.er_accident_type_id END AS AETYPE,
CASE LENGTH(r.accident_place_type_id )
WHEN 1 THEN CONCAT('0',r.accident_place_type_id)
ELSE r.accident_place_type_id END AS AEPLACE,
IF(r.visit_type IS NOT NULL,r.visit_type,9) AS TYPEIN_AE,
IF(r.accident_person_type_id IS NOT NULL,r.accident_person_type_id,9)  AS TRAFFIC,
IF(r.accident_transport_type_id IS NOT NULL,r.accident_transport_type_id,99) AS  VEHICLE,
r.accident_alcohol_type_id AS ALCOHOL,
r.accident_drug_type_id AS NACROTIC_DRUG,
r.accident_belt_type_id AS BELT,
r.accident_helmet_type_id AS HELMET,
r.accident_airway_type_id  AS AIRWAY,
r.accident_bleed_type_id AS STOPBLEED,
r.accident_splint_type_id AS SPLINT,
r.accident_fluid_type_id AS FLUID,
(SELECT CASE er.er_emergency_type
WHEN  '1' THEN  '2'
WHEN  '2' THEN  '3'
WHEN  '3' THEN  '4'
WHEN  '4' THEN  '5'
WHEN  '5' THEN  '1'
ELSE '6' END ) AS URGENCY,
r.gcs_e AS COMA_EYE,
r.gcs_v AS COMA_SPEAK,
r.gcs_m AS COMA_MOVEMENT,
IF(er.finish_time IS NULL OR TRIM(er.finish_time)='' OR er.finish_time LIKE '0000-00-00%','',DATE_FORMAT(er.finish_time,'%Y%m%d%H%i%s')) AS D_UPDATE,
v.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM er_nursing_detail r 
LEFT OUTER JOIN vn_stat v on v.vn = r.vn
LEFT OUTER JOIN er_regist er ON er.vn = r.vn AND er.vn = v.vn 
LEFT OUTER JOIN person p ON v.hn = p.patient_hn 

WHERE er.er_pt_type != 4

AND v.vstdate BETWEEN 20160601 AND 20160630

  



