SELECT 'IPD2559' as 'Y',count(a.an)
FROM ipt_labour l
LEFT OUTER JOIN ipt i ON i.an = l.an
LEFT OUTER JOIN an_stat a on a.an = l.an 
where a.pdx = 'O800'
AND i.dchdate BETWEEN 20151001 AND 20160930

UNION ALL

SELECT 'IPD2558' as 'Y',count(a.an)
FROM ipt_labour l
LEFT OUTER JOIN ipt i ON i.an = l.an
LEFT OUTER JOIN an_stat a on a.an = l.an 
where a.pdx = 'O800'
AND i.dchdate BETWEEN 20141001 AND 20150930

UNION ALL

SELECT 'IPD2557' as 'Y',count(a.an)
FROM ipt_labour l
LEFT OUTER JOIN ipt i ON i.an = l.an
LEFT OUTER JOIN an_stat a on a.an = l.an 
where a.pdx = 'O800'
AND i.dchdate BETWEEN 20131001 AND 20140930

UNION ALL

SELECT 'IPD2556' as 'Y',count(a.an)
FROM ipt_labour l
LEFT OUTER JOIN ipt i ON i.an = l.an
LEFT OUTER JOIN an_stat a on a.an = l.an 
where a.pdx = 'O800'
AND i.dchdate BETWEEN 20121001 AND 20130930

