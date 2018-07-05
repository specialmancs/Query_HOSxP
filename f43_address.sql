SELECT DISTINCT 
(SELECT hospitalcode FROM opdconfig) AS HOSPCODE,
pt.hn AS PID,
'1' AS ADDRESSTYPE,
CONCAT(IF(pt.chwpart IS NULL OR pt.chwpart = '',"99",pt.chwpart),IF(pt.amppart IS NULL OR pt.amppart = '',"99",pt.amppart),IF(pt.tmbpart IS NULL OR pt.tmbpart = '',"99",pt.tmbpart),'00') AS HOUSE_ID,
'9' AS HOUSETYPE,
(SELECT ' ') AS ROOMNO,
(SELECT ' ') AS CONDO,
pt.addrpart AS HOUSENO,
pt.addr_soi AS SOISUB,
(SELECT ' ') AS SOIMAIN,
pt.road  AS ROAD,
(SELECT ' ') AS VILLANAME,
pt.moopart AS VILLAGE,
IF(pt.tmbpart IS NULL OR pt.tmbpart = '',"99",pt.tmbpart) AS TAMBON,
IF(pt.amppart IS NULL OR pt.amppart = '',"99",pt.amppart) AS AMPUR,
IF(pt.chwpart IS NULL OR pt.chwpart = '',"99",pt.chwpart) AS CHANGWAT,
pt.hometel AS TELEPHONE,
pt.informtel AS MOBILE,
IF(pt.last_update IS NULL OR TRIM(pt.last_update )='' OR pt.last_update LIKE '0000-00-00%','',DATE_FORMAT(pt.last_update ,'%Y%m%d%H%i%s') ) AS D_UPDATE,
pt.cid AS CID
FROM patient pt
LEFT JOIN vn_stat v ON v.hn = pt.hn
WHERE (pt.cid <> '' AND pt.cid IS NOT NULL AND pt.cid NOT IN (SELECT cid FROM person) )
AND v.vstdate BETWEEN 20180101 AND 20180101

