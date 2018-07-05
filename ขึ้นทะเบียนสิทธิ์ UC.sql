SELECT '2560' Y,COUNT(DISTINCT(pt.hn)) as total
from patient_pttype pt 
INNER JOIN pttype p ON p.pttype = pt.pttype
WHERE begin_date BETWEEN 20161001 AND 20170930
AND p.pcode = 'UC'
AND pt.hospmain = '11207'

UNION ALL 

SELECT '2559' Y,COUNT(DISTINCT(pt.hn)) as total
from patient_pttype pt 
INNER JOIN pttype p ON p.pttype = pt.pttype
WHERE begin_date BETWEEN 20151001 AND 20160930
AND p.pcode = 'UC'
AND pt.hospmain = '11207'

UNION ALL

SELECT '2558' Y,COUNT(DISTINCT(pt.hn)) as total
from patient_pttype pt 
INNER JOIN pttype p ON p.pttype = pt.pttype
WHERE begin_date BETWEEN 20141001 AND 20150930
AND p.pcode = 'UC'
AND pt.hospmain = '11207'

UNION ALL

SELECT '2557' Y,COUNT(DISTINCT(pt.hn)) as total
from patient_pttype pt 
INNER JOIN pttype p ON p.pttype = pt.pttype
WHERE begin_date BETWEEN 20131001 AND 20140930
AND p.pcode = 'UC'
AND pt.hospmain = '11207'

UNION ALL

SELECT '2556' Y,COUNT(DISTINCT(pt.hn)) as total
from patient_pttype pt 
INNER JOIN pttype p ON p.pttype = pt.pttype
WHERE begin_date BETWEEN 20121001 AND 20130930
AND p.pcode = 'UC'
AND pt.hospmain = '11207'

