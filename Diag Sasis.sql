SET @y=2014;
SET @d1= concat(@y-1,"1001");
SET @d2= concat(@y,"1231");
SET @dx1="D562";
SET @dx2="D562";

SELECT an_stat.an,an_stat.hn,concat(patient.fname," ",patient.lname) as 'fname',pdx,dx0,age_y,age_m,age_d 
FROM an_stat LEFT JOIN patient ON patient.hn = an_stat.hn
WHERE (pdx BETWEEN "A410" AND "A419"
OR pdx BETWEEN "P360" AND "P369")
AND dchdate BETWEEN @d1 AND @d2
AND age_y BETWEEN 0 AND 12

UNION ALL 

SELECT an_stat.an,an_stat.hn,concat(patient.fname," ",patient.lname) as 'fname',pdx,dx0,age_y,age_m,age_d 
FROM an_stat LEFT JOIN patient ON patient.hn = an_stat.hn
WHERE (dx0 BETWEEN "A410" AND "A419"
OR dx0 BETWEEN "P360" AND "P369")
AND dchdate BETWEEN @d1 AND @d2
AND age_y BETWEEN 0 AND 12
