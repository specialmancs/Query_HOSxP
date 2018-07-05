SELECT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
p1.person_id AS PID,
p1.fake_seq_id AS SEQ,
IF(p2.screen_date IS NULL OR TRIM(p2.screen_date)='' OR p2.screen_date LIKE '0000-00-00%','',DATE_FORMAT(p2.screen_date,'%Y%m%d')) AS DATE_SERV,
(SELECT CASE (p2.in_hospital) 
WHEN 'Y' THEN '1'
ELSE '2' END) AS SERVPLACE,
(SELECT CASE (p4.present_smoking) 
WHEN 'Y' THEN '4'
WHEN '' THEN '9'
ELSE '1' END) AS SMOKE,
(SELECT CASE (p4.present_drinking_alcohol) 
WHEN 'Y' THEN '4'
WHEN '' THEN '9'
ELSE '1' END) AS ALCOHOL,
(SELECT CASE  
WHEN p4.family_relate_dm_disease = 'Y' THEN '1' 
WHEN p4.family_relate_unknown_disease = 'Y' THEN '9'
ELSE '2' END) AS DMFAMILY,
(SELECT CASE  WHEN p4.family_relate_ht_disease = 'Y' THEN '1' when p4.family_parent_unknown_disease = 'Y' THEN '9'
ELSE '2' END) AS HTFAMILY,
p2.body_weight AS WEIGHT,
p2.body_height AS HEIGHT,
p2.waist AS WAIST_CM,
p5.bps AS SBP_1,
p5.bpd AS DBP_1,
p6.bps AS SBP_2,
p6.bpd AS DBP_2,
p2.last_fgc AS BSLEVEL,
(SELECT CASE  
WHEN p2.last_fpg > '0' THEN '1' 
WHEN p2.last_fgc > '0' THEN '3' 
WHEN p2.ppg > '0' THEN '2' 
WHEN p2.last_fgc_no_food_limit > '0' THEN '4'
END) AS BSTEST,
(SELECT hospitalcode FROM opdconfig) AS SCREENPLACE,
(SELECT cid FROM doctor WHERE p2.doctor_code = `code`)AS PROVIDER,
IF( p1.last_screen_datetime  IS NULL OR TRIM(p1.last_screen_datetime )='' OR p1.last_screen_datetime  LIKE '0000-00-00%','',DATE_FORMAT(p1.last_screen_datetime ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p3.cid AS CID
FROM person_dmht_screen_summary p1
LEFT OUTER JOIN person_dmht_risk_screen_head p2 ON p1.person_dmht_screen_summary_id = p2.person_dmht_screen_summary_id 
LEFT OUTER JOIN person p3 ON p1.person_id=p3.person_id
LEFT OUTER JOIN person_dmht_nhso_screen p4 ON p1.person_dmht_screen_summary_id=p4.person_dmht_screen_summary_id
LEFT OUTER JOIN person_ht_risk_bp_screen p5 ON p5.person_dmht_risk_screen_head_id = p2.person_dmht_risk_screen_head_id AND p5.screen_no = 1
LEFT OUTER JOIN person_ht_risk_bp_screen p6 ON p6.person_dmht_risk_screen_head_id = p2.person_dmht_risk_screen_head_id AND p6.screen_no = 2
WHERE p1.person_dmht_screen_summary_id IN (SELECT DISTINCT person_dmht_screen_summary_id FROM person_dmht_risk_screen_head)
AND p1.status_active='Y' /*AND p3.person_id = 67527*/
/*Design By TAKIS TEAM 28/02/2556*/