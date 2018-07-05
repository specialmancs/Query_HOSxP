SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,lh.hn) AS PID,
/*lh.hn,*/
lh.vn AS SEQ,
IF(lh.order_date IS NULL OR TRIM(lh.order_date)='' OR lh.order_date LIKE '0000-00-00%','',DATE_FORMAT(lh.order_date,'%Y%m%d') ) AS DATE_SERV, 
CASE sys_var.sys_name
WHEN "lab_link_fbs" THEN '01'
WHEN "lab_link_2Hr" THEN '02'
WHEN "lab_link_DTX" THEN '03'
WHEN "lab_link_BloodSugar" THEN '04'
WHEN "lab_link_hba1c" THEN '05'
WHEN "lab_link_tg" THEN '06'
WHEN "lab_link_tc" THEN '07'
WHEN "lab_link_hdl" THEN '08'
WHEN "lab_link_ldl" THEN '09'
WHEN "lab_link_bun" THEN '10'
WHEN "lab_link_cr" THEN '11'
WHEN "lab_link_Micro_Albumine" THEN '12'
WHEN "lab_link_urine_creatinine"  THEN '13'
WHEN "lab_link_macro_albumin" THEN '14'
WHEN "lab_link_hb" THEN '16'
WHEN "lab_link_upcr" THEN '17'
WHEN "lab_link_tco2" THEN '18'
WHEN "lab_link_bicarb" THEN '19'
WHEN "lab_link_phosphate" THEN '20'
WHEN "lab_link_pth" THEN '21'
END AS LABTEST,
IF(lo.lab_order_result IS NOT NULL OR TRIM(lo.lab_order_result)<>'', REPLACE(FORMAT(lo.lab_order_result,2),',',''), FORMAT(0,2)) AS LABRESULT,
IF(concat(lh.report_date,' ',lh.report_time) IS NULL OR TRIM(concat(lh.report_date,' ',lh.report_time))='' OR concat(lh.report_date,' ',lh.report_time) LIKE '0000-00-00%',DATE_FORMAT(concat(lh.report_date,' ',lh.report_time),'%Y%m%d%H%i%s'),DATE_FORMAT(concat(lh.report_date,' ',lh.report_time),'%Y%m%d%H%i%s') ) AS D_UPDATE,  
IF(v.cid IS NOT NULL OR v.cid <> '',v.cid,pt.cid) AS CID
FROM lab_head lh
LEFT JOIN lab_order lo ON lh.lab_order_number = lo.lab_order_number
LEFT OUTER JOIN lab_items ON lo.lab_items_code = lab_items.lab_items_code
LEFT OUTER JOIN sys_var ON sys_var.sys_value = lab_items.lab_items_name 
LEFT OUTER JOIN patient pt ON lh.hn=pt.hn
LEFT OUTER JOIN doctor d ON d.code=lh.doctor_code  
LEFT OUTER JOIN vn_stat v ON v.vn=lh.vn  
LEFT OUTER JOIN spclty sp ON sp.spclty = lh.spclty  
LEFT OUTER JOIN an_stat a ON a.an=lh.vn  
LEFT OUTER JOIN kskdepartment k ON k.depcode = lh.order_department  
LEFT OUTER JOIN ward w ON w.ward = a.ward  
LEFT OUTER JOIN iptadm adm ON adm.an = a.an  
LEFT OUTER JOIN lab_perform_status lp ON lp.lab_perform_status_id = lh.lab_perform_status_id 
LEFT OUTER JOIN person p ON lh.hn = p.patient_hn
WHERE (sys_value IS NOT NULL AND sys_value <>'')
AND sys_var.sys_name IN ('lab_link_fbs' 
,'lab_link_2Hr' 
,'lab_link_DTX' 
,'lab_link_BloodSugar' 
,'lab_link_hba1c' 
,'lab_link_tg' 
,'lab_link_tc' 
,'lab_link_hdl' 
,'lab_link_ldl' 
,'lab_link_bun' 
,'lab_link_cr' 
,'lab_link_Micro_Albumine' 
,'lab_link_urine_creatinine'  
,'lab_link_macro_albumin' 
,'lab_link_hb' 
,'lab_link_upcr' 
,'lab_link_tco2'
,'lab_link_bicarb'
,'lab_link_phosphate'
,'lab_link_pth' )
/*AND lh.order_date between '2014-02-03' and '2014-02-03'*/
/*AND lh.hn IN(SELECT hn FROM clinicmember WHERE clinic IN (SELECT clinic FROM clinic WHERE chronic= 'Y')) AND lo.confirm = 'Y'*/
AND lp.lab_perform_status_name = 'รายงานผลแล้ว'
/*Design By TAKIS TEAM 02/02/2558 lab_link*/

UNION ALL

SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,lh.hn) AS PID,
/*lh.hn,*/
lh.vn AS SEQ,
IF(lh.order_date IS NULL OR TRIM(lh.order_date)='' OR lh.order_date LIKE '0000-00-00%','',DATE_FORMAT(lh.order_date,'%Y%m%d') ) AS DATE_SERV, 
CASE sys_lab_code.sys_lab_name
WHEN "FBS" THEN '01'
WHEN "2HR" THEN '02'
WHEN "DTX" THEN '03'
WHEN "BloodSugar" THEN '04'
WHEN "HbA1c" THEN '05'
WHEN "Triglyceride" THEN '06'
WHEN "Total Cholesterol" THEN '07'
WHEN "HDL" THEN '08'
WHEN "LDL" THEN '09'
WHEN "BUN" THEN '10'
WHEN "Creatinine" THEN '11'
WHEN "Micro Albumin" THEN '12'
WHEN "lab_link_Micro_Albumine" THEN '12'
WHEN "Urine Creatinine" THEN '13'
WHEN "Macro Albumin" THEN '14'
WHEN "Hb" THEN '16'
WHEN "UPCR" THEN '17'
WHEN "TCO2"  THEN '18'
WHEN "Bicarb"  THEN '19'
WHEN "Phosphate" THEN '20'
WHEN "PTH"  THEN '21'
END AS LABTEST,
IF(lo.lab_order_result IS NOT NULL OR TRIM(lo.lab_order_result)<>'', REPLACE(FORMAT(lo.lab_order_result,2),',',''), FORMAT(0,2)) AS LABRESULT,
IF(concat(lh.report_date,' ',lh.report_time) IS NULL OR TRIM(concat(lh.report_date,' ',lh.report_time))='' OR concat(lh.report_date,' ',lh.report_time) LIKE '0000-00-00%',DATE_FORMAT(concat(lh.report_date,' ',lh.report_time),'%Y%m%d%H%i%s'),DATE_FORMAT(concat(lh.report_date,' ',lh.report_time),'%Y%m%d%H%i%s') ) AS D_UPDATE,  
IF(v.cid IS NOT NULL OR v.cid <> '',v.cid,pt.cid) AS CID


FROM lab_head lh
LEFT JOIN lab_order lo ON lh.lab_order_number = lo.lab_order_number
LEFT OUTER JOIN lab_items ON lo.lab_items_code = lab_items.lab_items_code
LEFT OUTER JOIN sys_lab_link ON sys_lab_link.lab_items_code = lo.lab_items_code
LEFT OUTER JOIN sys_lab_code ON sys_lab_code.sys_lab_code_id = sys_lab_link.sys_lab_code_id
LEFT OUTER JOIN patient pt ON lh.hn=pt.hn
LEFT OUTER JOIN doctor d ON d.code=lh.doctor_code  
LEFT OUTER JOIN vn_stat v ON v.vn=lh.vn  
LEFT OUTER JOIN spclty sp ON sp.spclty = lh.spclty  
LEFT OUTER JOIN an_stat a ON a.an=lh.vn  
LEFT OUTER JOIN kskdepartment k ON k.depcode = lh.order_department  
LEFT OUTER JOIN ward w ON w.ward = a.ward  
LEFT OUTER JOIN iptadm adm ON adm.an = a.an  
LEFT OUTER JOIN lab_perform_status lp ON lp.lab_perform_status_id = lh.lab_perform_status_id 
LEFT OUTER JOIN person p ON lh.hn = p.patient_hn
WHERE (sys_lab_code.lab_items_name_list IS NOT NULL AND sys_lab_code.lab_items_name_list <>'')
AND sys_lab_code.sys_lab_name IN ('2HR',
        'DTX',
        'BloodSugar',
        'HbA1c',
        'Triglyceride',
        'Total Cholesterol',
        'HDL',
        'LDL',
        'BUN',
        'Creatinine',
        'Micro Albumin',
        'Urine Creatinine',
        'Macro Albumin',
        'Hb',
        'UPCR',
        'TCO2',
        'Bicarb',
        'Phosphate',
        'PTH')
And lh.order_date between 20161001 and 20161031
/*AND lh.hn IN(SELECT hn FROM clinicmember WHERE clinic IN (SELECT clinic FROM clinic WHERE chronic= 'Y')) AND lo.confirm = 'Y'*/
AND lp.lab_perform_status_name = 'รายงานผลแล้ว'
/*Design By TAKIS TEAM 02/02/2558 lab_multiple_link */

UNION ALL

SELECT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,ov.hn) AS PID,
ov.vn AS SEQ,
IF(ov.vstdate IS NULL OR TRIM(ov.vstdate )='' OR ov.vstdate  LIKE '0000-00-00%','',DATE_FORMAT(ov.vstdate ,'%Y%m%d') ) AS DATE_SERV,
'15' AS LABTEST,
IF(ovqg.ckd_epi IS NOT NULL OR TRIM(ovqg.ckd_epi)<>'', REPLACE(FORMAT(ovqg.ckd_epi,2),',',''), FORMAT(0,2)) AS LABRESULT,
CASE 
WHEN ov.vstdate IS NOT NULL AND ov.cur_dep_time IS NOT NULL  THEN DATE_FORMAT(CONCAT(ov.vstdate,' ',ov.cur_dep_time),"%Y%m%d%H%i%s")
WHEN ov.vstdate IS NOT NULL AND ov.cur_dep_time IS NULL  THEN DATE_FORMAT(CONCAT(ov.vstdate,' ',ov.vsttime),"%Y%m%d%H%i%s")
ELSE NULL END
AS D_UPDATE,
IF(vt.cid IS NOT NULL OR vt.cid <> '',vt.cid,pt.cid) AS CID

FROM ovst_gfr ovqg  
LEFT OUTER JOIN ovst ov ON ovqg.vn = ov.vn  
LEFT OUTER JOIN patient pt ON pt.hn=ov.hn 
LEFT OUTER JOIN ovstdiag odx ON odx.vn=ov.vn and odx.diagtype= '1' 
LEFT OUTER JOIN kskdepartment sp ON sp.depcode=ov.cur_dep 
LEFT OUTER JOIN ovstost oost ON oost.ovstost=ov.ovstost 
LEFT OUTER JOIN icd101 icd1 ON icd1.code=odx.icd10 
LEFT OUTER JOIN icd101 ix ON ix.code=substring(odx.icd10,1,3)  
LEFT OUTER JOIN pttype pty ON pty.pttype=ov.pttype  
LEFT OUTER JOIN vn_lock vk ON vk.vn = ov.vn 
LEFT OUTER JOIN ovstist st ON st.ovstist = ov.ovstist  
LEFT OUTER JOIN vn_stat vt ON vt.vn=ov.vn  
LEFT OUTER JOIN vn_opd_complete c ON c.vn=ov.vn  
LEFT OUTER JOIN ovst_seq ovq ON ovq.vn = ov.vn  
LEFT OUTER JOIN person p ON p.patient_hn = odx.hn
WHERE ov.vstdate between 20161001 and 20161031

/*Design By Glison 27/01/2558*/