SELECT DISTINCT
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
IFNULL(p.person_id,opi.hn) AS PID,
opi.vn as SEQ,
IF(opi.vstdate  IS NULL OR TRIM(opi.vstdate)='' OR opi.vstdate  LIKE '0000-00-00%','',DATE_FORMAT(opi.vstdate ,'%Y%m%d') ) AS DATE_SERV,
/*IF(opi.vstdate  IS NULL OR TRIM(opi.vstdate)='' OR opi.vstdate  LIKE '0000-00-00%','',DATE_FORMAT(opi.vstdate ,'%Y')) AS yearr,*/
sp.provis_code AS CLINIC,
d.did AS DIDSTD,
d.name AS DNAME,
opi.qty AS AMOUNT,
d.packqty AS UNIT,
d.units  AS UNIT_PACKING,
opi.unitprice AS DRUGPRICE, 
d.unitcost  AS DRUGCOST, 
doc.cid AS PROVIDER,
IF( opi.last_modified  IS NULL OR TRIM(opi.last_modified)='' OR opi.last_modified  LIKE '0000-00-00%','',DATE_FORMAT(opi.last_modified,'%Y%m%d%H%i%s') ) AS D_UPDATE ,
IF(p.cid IS NOT NULL OR p.cid <> '',p.cid,pt.cid) AS CID
FROM opitemrece opi 
LEFT OUTER JOIN ovst o ON o.vn=opi.vn  AND o.hn=opi.hn
LEFT OUTER JOIN drugitems d ON opi.icode=d.icode
LEFT OUTER JOIN spclty sp ON o.spclty=sp.spclty
LEFT OUTER JOIN person p ON opi.hn=p.patient_hn 
LEFT OUTER JOIN patient pt ON pt.hn=o.hn 
LEFT OUTER JOIN doctor doc ON opi.doctor = doc.`code`
WHERE (opi.an IS NULL OR opi.an ='') AND opi.vn NOT IN (SELECT DISTINCT i.vn FROM ipt i WHERE i.vn=opi.vn) AND opi.icode IN (SELECT DISTINCT d.icode FROM drugitems d) 
AND opi.vstdate BETWEEN 20180101 AND 20180101
/*TEST AND opi.vn= 550126074449  AND opi.hn = 0022916 AND vn.vstdate = '2012-02-01'*/
/*Design By TAKIS TEAM 20/02/2558*/