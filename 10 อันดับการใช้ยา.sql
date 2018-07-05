SET @y = 2015;
SET @d = concat(@y-1,'1001');
SET @e = concat(@y,'0930');

SELECT  o.icode,concat(d.`name`,' # ',d.strength,' #',d.dosageform),d.did,COUNT(o.icode),sum(o.sum_price)
FROM opitemrece o
INNER JOIN drugitems d ON d.icode = o.icode

WHERE o.vstdate BETWEEN @d AND @e
GROUP BY o.icode
ORDER BY COUNT(o.icode) desc 
limit 10