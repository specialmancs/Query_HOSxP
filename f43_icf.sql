SELECT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IF(pd.deformed_no IS NULL OR pd.deformed_no ='',pr.physic_main_regist_id,pd.deformed_no) as DISABID,
IFNULL(p.person_id,o.hn) AS PID,
oi.vn AS SEQ,
IF(o.vstdate IS NULL OR TRIM(o.vstdate)='' OR o.vstdate LIKE '0000-00-00%','',DATE_FORMAT(o.vstdate,'%Y%m%d') ) AS DATE_SERRV,
oi.ovst_icf_type_id as ICF,
oi.ovst_icf_level_type_id as QUALIFIER,
(SELECT cid FROM doctor WHERE o.doctor = `code`) AS PROVIDER,
IF( oi.entry_datetime IS NULL OR TRIM(oi.entry_datetime)='' OR oi.entry_datetime LIKE '0000-00-00%','',DATE_FORMAT(oi.entry_datetime,'%Y%m%d%H%i%s') ) AS D_UPDATE,
p.cid AS CID,
p.patient_hn as HN,
concat(p.pname,p.fname," ",p.lname) as ptname,
p.house_regist_type_id as typearea,
p.person_discharge_id as discharge

FROM ovst_icf oi 
LEFT OUTER JOIN ovst o ON oi.vn=o.vn
LEFT OUTER JOIN person p ON o.hn=p.patient_hn
LEFT OUTER JOIN person_deformed pd ON p.person_id=pd.person_id
LEFT OUTER JOIN physic_main_regist  pr ON pr.hn = p.patient_hn

WHERE o.vstdate between 20161001 AND 20170930