SELECT o.hn,o.vstdate,o.pdx,pt.`name`,o.item_money,o.paid_money 
from vn_stat o
LEFT JOIN pttype pt ON o.pttype = pt.pttype
WHERE vstdate BETWEEN 20180101 AND 20180131
AND vn not in (SELECT vn from an_stat)

ORDER BY item_money desc

LIMIT 10