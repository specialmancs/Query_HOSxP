SET @ds = 20151001;
SET @de = 20160930;

SELECT count(o.vn) as visit_all

,(SELECT count(v.vn) 
from vn_stat as v
WHERE v.vstdate between @ds AND @de
AND v.vn not in (SELECT vn from an_stat)
)as v_vn 
,(SELECT (count(v.vn)/286) 
from vn_stat as v
WHERE v.vstdate between @ds AND @de
AND v.vn not in (SELECT vn from an_stat)
)as v_vn_avg
,(SELECT count(v.vn)
from vn_stat as v
LEFT JOIN ovst  as o ON o.vn = v.vn
WHERE v.vstdate between @ds AND @de AND o.vsttime between '00:00:00' AND '07:31:00' AND v.vn not in (SELECT vn from an_stat)
OR v.vstdate between @ds AND @de AND o.vsttime BETWEEN '16:30:00' AND '23:59:59' AND v.vn not in (SELECT vn from an_stat)
) as v_an_out


,(SELECT count(a.an) 
from an_stat as a
WHERE a.regdate between @ds AND @de
)as v_an 
,(SELECT (count(a.an)/286) 
from an_stat as a
WHERE a.regdate between @ds AND @de
)as v_an_avg
,(SELECT count(a.an)
from an_stat as a
LEFT JOIN iptadm  as i ON i.an = a.an
WHERE a.regdate between @ds AND @de AND i.intime between '00:00:00' AND '07:31:00'
OR a.regdate between @ds AND @de AND i.intime BETWEEN '16:30:00' AND '23:59:59'
) as v_an_out

from ovst as o
WHERE o.vstdate between @ds AND @de


