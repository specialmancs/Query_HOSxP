SELECT t.hn,t.an,t.vstdate,t.dchdate,t.arrear_date,t.pttype,t.pttype_name,
IFNULL(t.ptname1,t.ptname2) as ptname,
IFNULL(t.cid1,t.cid2) as cid,
t.amount,t.OK,
IFNULL(t.addr1,t.addr2) as address
FROM(
select pa.hn,pa.an,pa.pttype,pt.name as 'pttype_name',o.vstdate,i.dchdate,pa.arrear_date,pa.amount

,concat(p1.pname," ",p1.fname," ",p1.lname) as ptname1
,concat(p2.pname," ",p2.fname," ",p2.lname) as ptname2 			
,p1.cid as cid1
,p2.cid as cid2
,concat(p1.addrpart," หมู่ที่ ",p1.moopart," ",t1.full_name," ",p1.po_code) as addr1
,concat(p2.addrpart," หมู่ที่ ",p2.moopart," ",t2.full_name," ",p2.po_code) as addr2
,case when pad.status_ok= "Y" then "ชำระแล้ว" else "ค้างชำระ" end as OK  

from patient_arrear pa                                                                  
left join ovst o on o.vn = pa.vn                                                       
left join ipt i on i.an = pa.an                                                      
left join patient p1 on p1.hn = o.hn
left join patient p2 on p2.hn = i.hn                                                   
left join patient_arrear_detail pad on pad.patient_arrear_id = pa.patient_arrear_id 
LEFT JOIN pttype pt on pa.pttype = pt.pttype 
 
left outer join thaiaddress t1 on concat(t1.chwpart,t1.amppart,t1.tmbpart) = concat(p1.chwpart,p1.amppart,p1.tmbpart)
left outer join thaiaddress t2 on concat(t2.chwpart,t2.amppart,t2.tmbpart) = concat(p2.chwpart,p2.amppart,p2.tmbpart)

where pa.arrear_date between 20151001 and 20170930 
AND  pad.status_ok = 'N'
AND pa.pttype not in ('89')                
group by pad.patient_arrear_id 

ORDER BY pa.arrear_date DESC
) t 