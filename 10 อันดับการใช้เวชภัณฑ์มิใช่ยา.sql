SET @y = 2017;
SET @d = concat(@y-1,'1001');
SET @e = concat(@y,'0930');

SELECT  o.icode,d.`name`,COUNT(o.icode),sum(o.sum_price)
FROM opitemrece o
INNER JOIN nondrugitems d ON d.icode = o.icode

WHERE o.vstdate BETWEEN @d AND @e
AND d.income = 05
GROUP BY o.icode
ORDER BY COUNT(o.icode) desc 
limit 10