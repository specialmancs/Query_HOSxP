SELECT COUNT(vn) as visitAll ,COUNT(DISTINCT(hn)) as HNAll ,
(SELECT count(vn)  from vn_stat 
where vstdate BETWEEN 20150901 AND 20160831
and pdx like "J00%") as visitJ00,
(SELECT COUNT(DISTINCT(hn))  from vn_stat 
where vstdate BETWEEN 20150901 AND 20160831
and pdx like "J00%") as HNJ00

FROM vn_stat

WHERE vstdate BETWEEN 20150901 AND 20160831

UNION ALL

SELECT COUNT(an) as visitAll ,COUNT(DISTINCT(hn)) as HNAll ,
(SELECT count(vn)  from vn_stat 
where vstdate BETWEEN 20150901 AND 20160831
and pdx like "J00%") as visitJ00,
(SELECT COUNT(DISTINCT(hn))  from vn_stat 
where vstdate BETWEEN 20150901 AND 20160831
and pdx like "J00%") as HNJ00

FROM an_stat 

WHERE regdate BETWEEN 20150901 AND 20160831
