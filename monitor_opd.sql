

 select oc.vn,oc.hn,oc.vstdate,oc.vsttime,o.oqueue,concat(p.pname,p.fname," ",p.lname) as ptname
	,s.name as spclty_name,  sti.name as ovstist_name , k.department as department_name
	,GROUP_CONCAT(k2.department) as register_department_name,pw.name as pt_walk_name
	,oc.height,oc.waist,oc.bmi,oc.bpd,oc.bps,oc.bw,oc.hr,oc.pe,oc.pulse,oc.rr,oc.temperature
	,oc.cc,oc.hpi,oc.pmh,t.name as pttype_name ,o.pttypeno,i.name as pdx_name,st.name as ost_name
	,hd.name as hospital_department_name ,GROUP_CONCAT(oq.doctor_list_text) as doctor_list_text
	,ssp.sub_spclty_name,vt.visit_type_name ,v.age_y,v.age_m,v.age_d,v.income
  ,(select count(vn) from opdscreen where date(vstdate) = curdate() ) as countvn
 
  from ovst o  
  left outer join vn_stat v on v.vn = o.vn  
  left outer join opdscreen oc on oc.vn = o.vn  #สกีนคนไข้
  left outer join patient p on p.hn = o.hn  # person
  left outer join pttype t on t.pttype = o.pttype  
  left outer join icd101 i on i.code = v.main_pdx  
  left outer join spclty s on s.spclty = o.spclty  
  left outer join ovstist sti on sti.ovstist = o.ovstist  #ประเภทการมา
  left outer join ovstost st on st.ovstost = o.ovstost  #สถานะการป่วย Admit ตรวจแล้ว
  left outer join ovst_seq oq on oq.vn = o.vn  
  left outer join ovst_nhso_send oo1 on oo1.vn = o.vn  
  left outer join kskdepartment k on k.depcode = o.cur_dep
	left outer join opd_dep_queue que on que.vn = o.vn 
	left outer join kskdepartment k2 on k2.depcode = que.depcode  
  #left outer join kskdepartment k2 on k2.depcode = oq.register_depcode  
  left outer join hospital_department hd on hd.id = oq.hospital_department_id  
  left outer join sub_spclty ssp on ssp.sub_spclty_id = oq.sub_spclty_id  
  left outer join pt_walk pw on pw.walk_id = oc.walk_id  # การมา *เดินมา *อุ้มมา
  left outer join visit_type vt on vt.visit_type = o.visit_type   #ในเวลา   นอกเวลา
  left outer join ipt i3 on i3.vn = o.vn  #IPD
	

where  date(oc.vstdate) = curdate()  
AND que.depcode not in ('057','059','060','999')
GROUP BY oc.vn,oc.hn
ORDER BY oc.vstdate,oc.vsttime desc;
