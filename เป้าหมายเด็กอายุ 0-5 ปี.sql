SET @years = '2017';

SELECT pt.hn,p.person_id as PID,pt.cid,
if( p.person_id is not null,concat(p.pname,p.fname," ",p.lname),concat(pt.pname,pt.fname," ",pt.lname)) as ptname,
pt.birthday,concat(if(pt.sex = 2,'หญิง',''),if(pt.sex = 1,'ชาย','')) as sex,
timestampdiff(year,pt.birthday,curdate()) as Y,
timestampdiff(month,pt.birthday,curdate())-(timestampdiff(year,pt.birthday,curdate())*12) as M,
timestampdiff(day,date_add(pt.birthday,interval (timestampdiff(month,pt.birthday,curdate())) month),curdate()) as D,
concat(
if(pt.birthday BETWEEN concat(@years-2,'1001') AND concat(@years,'0930'),'ช่วง 0-1 ปี',''),
if(pt.birthday BETWEEN concat(@years-3,'1001') AND concat(@years-2,'0930'),'ช่วง 2 ปี',''),
if(pt.birthday BETWEEN concat(@years-4,'1001') AND concat(@years-3,'0930'),'ช่วง 3 ปี',''),
if(pt.birthday BETWEEN concat(@years-6,'1001') AND concat(@years-5,'0930'),'ช่วง 5 ปี','')
)as status_p,
p.house_regist_type_id as typearea,p.person_discharge_id as discharge,pt.informaddr
from patient as pt 
LEFT OUTER JOIN person as p ON p.patient_hn = pt.hn AND p.cid = pt.cid

WHERE pt.birthday BETWEEN concat(@years-6,'1001') AND concat(@years,'0930')
AND pt.birthday NOT BETWEEN concat(@years-5,'1001') AND concat(@years-4,'0930')
AND p.house_regist_type_id in (1,3)
AND pt.hn not in (select hn from death)

ORDER BY pt.birthday desc


