SELECT year(vstdate) 'y',month(vstdate) 'm',
count(vn) 'all',
sum(if(vsttime BETWEEN '08:00:00' AND '16:00:00',1,0)) 'เช้า',
sum(if(vsttime BETWEEN '16:00:01' AND '23:59:59',1,0)) 'บ่าย',
sum(if(vsttime BETWEEN '00:00:01' AND '07:59:59',1,0)) 'ดึก'

from ovst o
where vstdate BETWEEN 20161001 AND 20180331

AND vstdate not in (select holiday_date from holiday WHERE day_name in ('เสาร์','อาทิตย์') )
#AND vsttime BETWEEN '08:00:00' AND '16:00:00'
#AND vsttime BETWEEN '16:00:00' AND '23:59:59'
#AND vsttime BETWEEN '00:00:00' AND '07:59:59'
AND o.pttype in (19,20)

GROUP BY  year(vstdate),month(vstdate)