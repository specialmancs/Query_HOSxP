SELECT a.*, b.drugname as drug_ERIG, b.ERIG
FROM(
SELECT a.hospcode, a.cid, a.fname, a.lname, a.aid, 
       a.pdx, a.dx0, a.dx1, a.dx2, a.dx3, a.dx4, a.dx5, a.age_y, a.age_m, a.drugname,
       GROUP_CONCAT(a.vstdate ORDER BY a.vstdate) as 'Rabies'
FROM(
SELECT '11207' as 'hospcode', v.cid, p2.fname, p2.lname, v.aid, v.vstdate, 
       v.pdx, v.dx0, v.dx1, v.dx2, v.dx3, v.dx4, v.dx5, v.age_y, v.age_m,m.name as 'drugname'       
FROM  opitemrece o
     left join  vn_stat v on o.vn = v.vn      
     left join  patient p2 on  v.hn = p2.hn
     left join  drugitems m on o.icode = m.icode 
WHERE v.vstdate BETWEEN 20170101 and 20171231
     and o.icode in ('3002251','3002252','3002253','3002254','3002255')#เปลี่ยนรหัสยา icode
ORDER BY v.cid, v.vstdate) a 
GROUP BY a.CID ) a left outer join 

(SELECT a.hospcode, a.cid, a.fname, a.lname, a.aid, 
       a.pdx, a.dx0, a.dx1, a.dx2, a.dx3, a.dx4, a.dx5, a.age_y, a.age_m, a.drugname,
       GROUP_CONCAT(a.vstdate ORDER BY a.vstdate) as 'ERIG'
FROM(
SELECT '11207' as 'hospcode', v.cid, p2.fname, p2.lname, v.aid, v.vstdate, 
       v.pdx, v.dx0, v.dx1, v.dx2, v.dx3, v.dx4, v.dx5, v.age_y, v.age_m,m.name as drugname       
FROM  opitemrece o
     left join  vn_stat v on o.vn = v.vn      
     left outer join  patient p2 on  v.hn = p2.hn
     left outer join  drugitems m on m.icode=o.icode  
WHERE v.vstdate BETWEEN 20150101 and 20171231
     and o.icode in ('') #เปลี่ยนรหัสยา icode
ORDER BY v.cid, v.vstdate) a 
GROUP BY a.CID ) b on a.CID = b.CID