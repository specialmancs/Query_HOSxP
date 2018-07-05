SET @y = 2018;
SET @d1= concat(@y-1,"0320");
SET @d2= concat(@y,"1231");
SET @dx1= "";
SET @dx2="D562";

select t.* from (
SELECT v.vn,a.an,o.hn,v.pdx as opd_diag,a.pdx as ipd_diag,p.type_area,o.vstdate as 'last_visit'

from ovst as o
LEFT OUTER JOIN vn_stat as v ON v.vn = o.vn
LEFT OUTER JOIN an_stat as a ON a.vn = o.vn
LEFT OUTER JOIN opdscreen as op ON op.vn = v.vn
LEFT OUTER JOIN ipt as ip ON ip.vn = a.vn
LEFT OUTER JOIN patient as p ON p.hn = o.hn 

WHERE o.vstdate between @d1 AND @d2 
AND (	v.pdx BETWEEN 'I10' AND 'I15' or
			v.pdx	BETWEEN 'E10' AND 'E14' or 
			v.pdx	BETWEEN 'N17' AND 'N19'  
)




UNION ALL

SELECT v.vn,a.an,o.hn,v.pdx as opd_diag,a.pdx as ipd_diag,p.type_area,o.vstdate as 'last_visit'
from ovst as o
LEFT OUTER JOIN vn_stat as v ON v.vn = o.vn
LEFT OUTER JOIN an_stat as a ON a.vn = o.vn
LEFT OUTER JOIN opdscreen as op ON op.vn = v.vn
LEFT OUTER JOIN ipt as ip ON ip.vn = a.vn
LEFT OUTER JOIN patient as p ON p.hn = o.hn 

WHERE o.vstdate between @d1 AND @d2
AND (	a.pdx BETWEEN 'I10' AND 'I15' or
			a.pdx	BETWEEN 'E10' AND 'E14' or 
			a.pdx	BETWEEN 'N17' AND 'N19'  
)



)t

group by t.hn
