SELECT p.cid,p.fname,p.lname,p.sex,CONCAT(DATE_FORMAT(p.birthdate,'%d/%m/'),DATE_FORMAT(p.birthdate,'%Y')+543) AS birth,'ป1' AS level_edu
 FROM village_student st
 LEFT OUTER JOIN person p ON st.person_id=p.person_id 
 LEFT OUTER JOIN village_school s ON st.village_school_id=s.village_school_id
 LEFT OUTER JOIN village_school_class c ON st.village_school_class_id=c.village_school_class_id
 WHERE st.village_school_id != '' #รหัสโรงเรียน
 AND c.village_school_class_id = '4'
 AND st.discharge='N'
 ORDER BY s.school_name,st.village_school_class_id ASC