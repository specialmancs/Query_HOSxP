select hn,cid,pname,fname,lname,sex,birthday,informaddr,type_area 

from patient
where concat(fname,lname) in 
(select concat(fname,lname) from patient
group by fname,lname
having count(hn) > 1)
order by fname, lname, birthday, hn