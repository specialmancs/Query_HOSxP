SELECT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,pt.hn) AS PID,
o.vn as SEQ,
IF(c.screen_date IS NULL OR TRIM(c.screen_date)='' OR c.screen_date LIKE '0000-00-00%','',DATE_FORMAT(c.screen_date,'%Y%m%d')) AS DATE_SERV,
IF(o.bw IS NOT NULL AND TRIM(o.bw )<>'', REPLACE(FORMAT(o.bw ,2),',',''), FORMAT(0,2)) AS WEIGHT,
IF(o.height IS NOT NULL AND TRIM(o.height )<>'', REPLACE(FORMAT(o.height ,2),',',''), FORMAT(0,2)) AS HEIGHT,
o.waist AS WAIST_CM,
IF(o.bps IS NOT NULL AND TRIM(o.bps )<>'', REPLACE(FORMAT(o.bps ,0),',',''), FORMAT(0,0)) AS SBP,
IF(o.bpd IS NOT NULL AND TRIM(o.bpd )<>'', REPLACE(FORMAT(o.bpd ,0),',',''), FORMAT(0,0)) AS DBP,
(SELECT CASE (CONCAT(cfs.dmht_foot_scr_res_left_id,cfs.dmht_foot_scr_res_right_id)) 
WHEN '00' THEN '2'
WHEN '11' THEN '1'
WHEN '12' THEN '3'
WHEN '13' THEN '3'
WHEN '14' THEN '3'
WHEN '21' THEN '3'
WHEN '22' THEN '3'
WHEN '23' THEN '3'
WHEN '24' THEN '3'
WHEN '31' THEN '3'
WHEN '32' THEN '3'
WHEN '33' THEN '3'
WHEN '34' THEN '3'
WHEN '41' THEN '3'
WHEN '42' THEN '3'
WHEN '43' THEN '3'
WHEN '44' THEN '3'
ELSE '9' END) AS FOOT,
(SELECT CASE (CONCAT(ce.dmht_eye_screen_type_id,ce.dmht_eye_screen_res_left_id,ce.dmht_eye_screen_res_right_id)) 
WHEN '111' THEN '1' 
WHEN '122' THEN '3'
WHEN '123' THEN '3'
WHEN '124' THEN '3'
WHEN '125' THEN '3'
WHEN '132' THEN '3'
WHEN '133' THEN '3'
WHEN '134' THEN '3'
WHEN '135' THEN '3'
WHEN '142' THEN '3'
WHEN '143' THEN '3'
WHEN '144' THEN '3'
WHEN '145' THEN '3'
WHEN '152' THEN '3'
WHEN '153' THEN '3'
WHEN '154' THEN '3'
WHEN '155' THEN '3'
WHEN '211' THEN '2'
WHEN '222' THEN '4'
WHEN '223' THEN '4'
WHEN '224' THEN '4'
WHEN '225' THEN '4'
WHEN '232' THEN '4'
WHEN '233' THEN '4'
WHEN '234' THEN '4'
WHEN '235' THEN '4'
WHEN '242' THEN '4'
WHEN '243' THEN '4'
WHEN '244' THEN '4'
WHEN '245' THEN '4'
WHEN '252' THEN '4'
WHEN '253' THEN '4'
WHEN '254' THEN '4'
WHEN '255' THEN '4'
ELSE '9' END) AS RETINA, 
(SELECT cid FROM doctor d,ovst ov WHERE ov.doctor = d.`code` AND ov.vn=o.vn AND ov.hn=o.hn)  AS PROVIDER,
IF( c.update_datetime IS NULL OR TRIM(c.update_datetime )='' OR c.update_datetime LIKE '0000-00-00%','',DATE_FORMAT(c.update_datetime ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
IF(p.cid IS NOT NULL OR p.cid <> '',p.cid,pt.cid) AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM cm_dm_cmbty_screen c
LEFT OUTER JOIN opdscreen o ON c.vn=o.vn AND c.hn=o.hn
LEFT OUTER JOIN patient pt ON c.hn=pt.hn
LEFT OUTER JOIN person p ON c.hn=p.patient_hn 
LEFT OUTER JOIN clinicmember cl ON c.clinicmember_id=cl.clinicmember_id
LEFT OUTER JOIN cm_dm_cmbty_foot_screen cfs ON c.cm_dm_cmbty_screen_id=cfs.cm_dm_cmbty_screen_id
LEFT OUTER JOIN cm_dm_cmbty_eye_screen ce ON c.cm_dm_cmbty_screen_id=ce.cm_dm_cmbty_screen_id

WHERE c.screen_date between 20151001 AND 20160630
/*Design By TAKIS TEAM 17/02/2558*/