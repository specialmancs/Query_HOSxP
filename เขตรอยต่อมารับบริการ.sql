SELECT concat(p.chwpart,p.amppart,p.tmbpart,p.moopart) as 'VHID',
concat(" จ.",t1.name," อ.",t2.name," ต.",t3.name) as ssname,p.moopart as 'Moo',
count(o.vn) as 'visit'

from ovst o
LEFT JOIN patient p on o.hn = p.hn
left outer join thaiaddress t on t.addressid = concat(p.chwpart,p.amppart,p.tmbpart)
left outer join thaiaddress t1 on t1.chwpart = p.chwpart and 
     t1.amppart = "00" and t1.tmbpart = "00"
left outer join thaiaddress t2 on t2.chwpart = p.chwpart and 
     t2.amppart = p.amppart and t2.tmbpart = "00" 
left outer join thaiaddress t3 on t3.chwpart = p.chwpart and 
     t3.amppart = p.amppart and t3.tmbpart = p.tmbpart 

WHERE concat(p.chwpart,p.amppart,p.tmbpart,p.moopart) in (63050501,63050502,63050503,63050504,63050505,63050506,63050507,63050508
,63050509,50180501,50180510,50180512,50180402,50180501,50180515)
AND o.vstdate BETWEEN 20151001 AND 20160930

GROUP BY concat(p.chwpart,p.amppart,p.tmbpart,p.moopart)
ORDER BY concat(p.chwpart,p.amppart,p.tmbpart,p.moopart) asc