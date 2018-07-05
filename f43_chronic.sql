SELECT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,	
IFNULL(ps.person_id,p.hn) AS PID,
IF(c.regdate IS NULL OR TRIM(c.regdate)='' OR c.regdate LIKE '0000-00-00%','',DATE_FORMAT(c.regdate,'%Y%m%d')) AS DATE_DIAG,
(SELECT CASE (s.sys_name) 
WHEN 'dm_clinic_code' THEN 'E11' 
WHEN 'ht_clinic_code' THEN 'I10' 
WHEN 'tb_clinic_code' THEN 'J19' 
WHEN 'copd_clinic_code' THEN 'J44' 
WHEN 'asthma_clinic_code' THEN 'J45' 
ELSE NULL END) AS CHRONIC,
(SELECT CASE (c.new_case) 
WHEN 'Y' THEN (SELECT hospitalcode FROM opdconfig) 
ELSE '' END) AS  HOSP_DX,
IF(c.send_to_pcu_hcode IS NOT NULL OR c.send_to_pcu_hcode <> '',c.send_to_pcu_hcode,(SELECT hospitalcode FROM opdconfig)) AS HOSP_RX,
IF(c.dchdate IS NULL OR TRIM(c.dchdate)='' OR c.dchdate LIKE '0000-00-00%','',DATE_FORMAT(c.dchdate,'%Y%m%d')) AS DATE_DISCH,
IF(cm.provis_typedis = '0','04',cm.provis_typedis) AS TYPEDISCH,
IF(c.lastupdate IS NULL OR TRIM(c.lastupdate)='' OR c.lastupdate LIKE '0000-00-00%','',DATE_FORMAT(c.lastupdate,'%Y%m%d%H%i%s') ) AS D_UPDATE,
IF(ps.cid IS NOT NULL OR ps.cid <> '',ps.cid,p.cid) AS CID,
ps.patient_hn as HN,
concat(ps.pname,ps.fname," ",ps.lname) as ptname,
ps.house_regist_type_id as typearea,
ps.person_discharge_id as discharge

FROM clinicmember c  
LEFT OUTER JOIN clinic n ON c.clinic = n.clinic
LEFT OUTER JOIN clinic_member_status cm ON cm.clinic_member_status_id = c.clinic_member_status_id  
LEFT JOIN sys_var s ON c.clinic = s.sys_value  
LEFT OUTER JOIN patient p ON p.hn = c.hn  
LEFT OUTER JOIN person ps ON c.hn=ps.patient_hn AND p.cid = ps.cid
LEFT OUTER JOIN opduser u ON u.loginname = c.modify_staff  
LEFT OUTER JOIN ovst ov1 ON ov1.vn = c.last_cormobidity_screen_vn 
WHERE s.sys_name IN ('dm_clinic_code','ht_clinic_code','tb_clinic_code','copd_clinic_code','asthma_clinic_code')  
#WHERE c.clinic IN (SELECT sys_value FROM  sys_var WHERE sys_name IN ('dm_clinic_code','ht_clinic_code'))
AND c.regdate BETWEEN 20151001 AND 20160930
GROUP BY  c.clinicmember_id
ORDER BY ps.person_id
/*Design By TAKIS TEAM 17/02/2558*/