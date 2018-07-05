SELECT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,pt.hn) AS PID,
ov.vn as SEQ,
IF(ov.vstdate  IS NULL OR TRIM(ov.vstdate)='' OR ov.vstdate  LIKE '0000-00-00%','',DATE_FORMAT(ov.vstdate ,'%Y%m%d') ) AS DATE_SERV,
odx.diagtype AS DIAGTYPE,
odx.icd10 AS DIAGCODE, 
IFNULL(spc.provis_code,'') AS CLINIC,
IFNULL((SELECT cid FROM doctor WHERE odx.doctor = `code`),'') AS PROVIDER,
CASE 
WHEN ov.vstdate IS NOT NULL AND ov.cur_dep_time IS NOT NULL  THEN DATE_FORMAT(CONCAT(ov.vstdate,' ',ov.cur_dep_time),"%Y%m%d%H%i%s")
WHEN ov.vstdate IS NOT NULL AND ov.cur_dep_time IS NULL  THEN DATE_FORMAT(CONCAT(ov.vstdate,' ',ov.vsttime),"%Y%m%d%H%i%s")
ELSE NULL END
AS D_UPDATE,
/*ov.cur_dep_time,ov.vsttime,*/
IF(p.cid IS NOT NULL OR p.cid <> '',p.cid,pt.cid) AS CID
FROM ovst ov 
LEFT OUTER JOIN patient pt ON pt.hn=ov.hn 
LEFT OUTER JOIN ovstdiag odx ON odx.vn=ov.vn 
LEFT OUTER JOIN kskdepartment sp ON sp.depcode=ov.cur_dep 
LEFT OUTER JOIN ovstost oost ON oost.ovstost=ov.ovstost 
LEFT OUTER JOIN icd101 icd1 ON icd1.code=odx.icd10 
LEFT OUTER JOIN icd101 ix ON ix.code = substring(odx.icd10,1,3)  
LEFT OUTER JOIN vn_stat vt ON vt.vn=ov.vn  
LEFT OUTER JOIN ovst_drgs od ON od.vn = ov.vn 
LEFT OUTER JOIN oapp ON oapp.vn=ov.vn and oapp.app_no = 1 
LEFT OUTER JOIN person p ON p.patient_hn = odx.hn
LEFT OUTER JOIN vn_opd_complete c ON c.vn=ov.vn  
LEFT OUTER JOIN ovst_seq ovq ON ovq.vn = ov.vn  
LEFT OUTER JOIN spclty spc ON ov.spclty = spc.spclty
WHERE ov.vstdate  BETWEEN 20180101 AND 20180101
AND ov.an IS NULL  
#AND (odx.diagtype IS NOT NULL OR odx.diagtype <> '')
ORDER BY ov.vsttime
/*Design By Glison 16/03/2558*/