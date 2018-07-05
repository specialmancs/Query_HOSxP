SELECT o.hn,dchdate,o.pdx,pt.`name`,o.item_money,o.paid_money 
from an_stat o
LEFT JOIN pttype pt ON o.pttype = pt.pttype
WHERE dchdate BETWEEN 20180101 AND 20180131


ORDER BY item_money desc

LIMIT 10