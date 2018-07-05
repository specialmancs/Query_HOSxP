SET @y = 2015;
SET @d = concat(@y-1,'1001');
SET @e = concat(@y,'0930');

select lab_code,lab_name,COUNT(o.lab_code),sum(o.price) as price 
from lab_order_service o 
left join lab_head h on h.lab_order_number=o.lab_order_number 
where h.order_date between @d and @e
and h.confirm_report="Y" 
group by o.lab_code 
ORDER BY COUNT(o.lab_code) DESC 
limit 10