SET @y = 2017;
SET @d = concat(@y,'0101');
SET @e = concat(@y,'1231');

SELECT  v.cid, p2.fname, p2.lname, v.aid, v.vstdate, 
       v.pdx, v.dx0, v.dx1, v.dx2, v.dx3, v.dx4, v.dx5, v.age_y, v.age_m
FROM  vn_stat v 
left join  patient p2 on  v.hn = p2.hn

WHERE v.vstdate BETWEEN @d and @e
and (
			v.pdx 		in ('W53','W54','W55')
			or v.pdx LIKE 'W54%'
			or v.dx0 	in ('W53','W54','W55')
			or v.dx0 LIKE 'W54%'
			or v.dx1 	in ('W53','W54','W55')
			or v.dx1 LIKE 'W54%'
		)
ORDER BY v.cid, v.vstdate
