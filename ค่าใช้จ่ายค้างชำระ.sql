SELECT t.ROOM,t.pttype,p.name,sum(t.income)as income,sum(t.uc) as uc,sum(t.bill) as bill,
IF(sum(t.bill) >1,
sum(t.income) - (sum(t.uc)+sum(t.bill) ) ,
sum(t.income) - sum(t.uc)  
)as total
from(

SELECT 'OPD' as 'ROOM',a.vstdate as vndate,a.hn,a.pttype,sum(a.item_money) as income,
sum(a.uc_money) as uc,b.bill_amount as 'bill'

 
from vn_stat a
LEFT JOIN rcpt_print b ON a.vn = b.vn 

WHERE a.pttype in(10,99,51,42,20)
AND a.vn not in (select vn from an_stat)
GROUP BY a.vn

UNION ALL

SELECT 'IPD' as 'ROOM',a.regdate as vndate,a.an,a.pttype,sum(a.item_money) as income,
sum(a.uc_money) as uc,b.bill_amount as 'bill'

 
from an_stat a
LEFT JOIN rcpt_print b ON a.an = b.vn 

WHERE a.pttype in(10,99,51,42,20)

GROUP BY a.an

)as t 

LEFT OUTER JOIN pttype p ON p.pttype = t.pttype

where t.vndate BETWEEN 20151001 AND 20160930

GROUP BY t.pttype,t.ROOM

ORDER BY t.ROOM desc