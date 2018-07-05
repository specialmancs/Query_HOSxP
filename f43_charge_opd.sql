SELECT 
(SELECT opdconfig.hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(person.person_id,pt.hn) AS PID,
o1.vn AS SEQ,
IF(CONCAT(o2.vstdate)IS NULL OR TRIM(CONCAT(o2.vstdate))=''OR CONCAT(o2.vstdate)LIKE "0000-00-00%",'',DATE_FORMAT(CONCAT(o2.vstdate),"%Y%m%d")) AS DATE_SERV,
IF (sp.provis_code IS NULL OR sp.provis_code ='' ,'00100',sp.provis_code ) AS CLINIC,
i.group2 AS CHARGEITEM,
IF(o1.icode IS NULL OR o1.icode ='' ,'0000000',o1.icode ) AS CHARGELIST,
o1.qty AS QUANTITY,
pts.pttype_std_code AS INSTYPE,
IF(o1.cost, REPLACE(FORMAT(o1.cost,2),',',''), FORMAT(0,2))AS COST,
IF(o1.unitprice, REPLACE(FORMAT(o1.unitprice,2),',',''), FORMAT(0,2)) AS PRICE,
IF(v.paid_money, REPLACE(FORMAT(v.paid_money,2),',',''), FORMAT(0,2)) AS PAYPRICE,
IF(CONCAT(q.update_datetime)IS NULL OR TRIM(CONCAT(q.update_datetime))=''OR CONCAT(q.update_datetime)LIKE "0000-00-00%",'',DATE_FORMAT(CONCAT(q.update_datetime),"%Y%m%d%H%i%s")) AS D_UPDATE,
IF(person.cid IS NOT NULL OR person.cid <> '',person.cid,pt.cid) AS CID
FROM opitemrece o1  
LEFT OUTER JOIN income i on i.income = o1.income  
LEFT OUTER JOIN pttype py on py.pttype = o1.pttype  
LEFT OUTER JOIN provis_instype pts on pts.code = py.nhso_code  
LEFT OUTER JOIN ovst o2 on o2.vn=o1.vn  
LEFT OUTER JOIN patient pt on pt.hn = o2.hn  
LEFT OUTER JOIN vn_stat v on v.vn=o1.vn  
LEFT OUTER JOIN ovst_seq q on q.vn = o2.vn  
LEFT OUTER JOIN spclty sp on sp.spclty = o2.spclty  
LEFT OUTER JOIN person ON person.cid = pt.cid 
WHERE (o1.an = '' OR o1.an IS NULL) AND o1.unitprice <> '0' AND o1.qty > '0' 
AND (q.update_datetime <> '' OR q.update_datetime IS NOT NULL) 
AND o2.vstdate BETWEEN  20180101 AND  20180131

limit 50000