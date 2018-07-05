SET @y=2016;
SET @d=concat(@y-1,'1001');
SET @e=concat(@y,'0930');

SELECT '2559' as 'YEAR','OPD' as 'Room','K279' as 'DIAG',
count(v.hn) as 'ครั้ง',count(DISTINCT(v.hn)) as 'คน'
from vn_stat v
WHERE v.pdx = 'K279'
AND v.vstdate BETWEEN @d AND @e

UNION ALL

SELECT '2559' as 'YEAR','OPD' as 'Room','K30' as 'DIAG',
count(v.hn) as 'ครั้ง',count(DISTINCT(v.hn)) as 'คน'
from vn_stat v
WHERE v.pdx = 'K30'
AND v.vstdate BETWEEN @d AND @e

UNION ALL

SELECT '2559' as 'YEAR','OPD' as 'Room','K219' as 'DIAG',
count(v.hn) as 'ครั้ง',count(DISTINCT(v.hn)) as 'คน'
from vn_stat v
WHERE v.pdx = 'K219'
AND v.vstdate BETWEEN @d AND @e


#########   IPD    ############

UNION ALL

SELECT '2559' as 'YEAR','OPD' as 'Room','K279' as 'DIAG',
count(a.hn) as 'ครั้ง',count(DISTINCT(a.hn)) as 'คน'
from an_stat a
WHERE a.pdx = 'K279'
AND a.regdate  BETWEEN @d AND @e

UNION ALL

SELECT '2559' as 'YEAR','OPD' as 'Room','K30' as 'DIAG',
count(a.hn) as 'ครั้ง',count(DISTINCT(a.hn)) as 'คน'
from an_stat a
WHERE a.pdx = 'K30'
AND a.regdate  BETWEEN @d AND @e

UNION ALL

SELECT '2559' as 'YEAR','OPD' as 'Room','K219' as 'DIAG',
count(a.hn) as 'ครั้ง',count(DISTINCT(a.hn)) as 'คน'
from an_stat a
WHERE a.pdx = 'K219'
AND a.regdate  BETWEEN @d AND @e

