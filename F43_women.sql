SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
w.person_id AS PID,
IF(wb.export_code IS NULL OR wb.export_code = '',9,wb.export_code) AS FPTYPE,
IFNULL((SELECT nofp_type_id FROM nofp_type nf WHERE nf.nofp_type_id=w.nofp_type_id),'') AS NOFPCAUSE,
IF(w.total_child_count IS NULL OR w.total_child_count = '',0,w.total_child_count)AS TOTALSON,
IF(w.child_alive_count IS NULL OR w.child_alive_count = '',0,w.child_alive_count) AS NUMBERSON,
IF(w.child_abortion_count IS NULL OR w.child_abortion_count = '',0,w.child_abortion_count) AS ABORTION,
IF(w.child_dead_still_birth_count IS NULL OR w.child_dead_still_birth_count = '',0,w.child_dead_still_birth_count) AS STILLBIRTH,
IF(w.last_update IS NULL OR TRIM(w.last_update)='' OR w.last_update LIKE '0000-00-00%','',DATE_FORMAT(w.last_update,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
w.regdate,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM person_women w 
LEFT OUTER JOIN person p ON w.person_id=p.person_id
LEFT OUTER JOIN women_birth_control wb ON w.women_birth_control_id = wb.women_birth_control_id 
WHERE (w.discharge <> 'Y' OR w.discharge IS NULL) AND (w.out_region = 'N' OR w.out_region IS NULL)
AND p.cid IS NOT  NULL AND p.marrystatus <> 1
AND w.regdate BETWEEN 20151001 AND 20160930
/*Design By TAKIS TEAM 24/03/2558*/