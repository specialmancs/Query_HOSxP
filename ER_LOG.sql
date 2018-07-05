select distinct v.vn,oc.vstdate,oc.vsttime,p.hn,concat(p.pname,p.fname," ",p.lname)as ptname,p.cid,
  vt.visit_type_name,pw.name as pt_walk_name,pt.pttype,pt.name,v.pdx,
  oc.height,oc.waist,oc.bmi,oc.bpd,oc.bps,oc.bw,oc.hr,oc.pe,oc.pulse,oc.rr,oc.temperature,
	oc.cc,oc.hpi,oc.pmh,erl.er_list,peri.`name` as er_period,ept.`name` as er_pt_type,eme.`name` as er_emergency_type,  
  k.department
                                                                               
  from er_regist erl
	LEFT OUTER JOIN  ovst_doctor_sign ods on ods.vn = erl.vn
  LEFT OUTER JOIN er_emergency_type eme on 	eme.er_emergency_type = erl.er_emergency_type
  LEFT OUTER JOIN er_pt_type ept on 	ept.er_pt_type = erl.er_pt_type
  LEFT OUTER JOIN er_period peri on 	peri.er_period = erl.er_period																																										
  left OUTER join vn_stat v on v.vn=erl.vn 
  left outer join ovst as o on o.vn = erl.vn                                                                            
  left OUTER join patient p on p.hn=v.hn                                                                               
  left OUTER join kskdepartment k on k.depcode = ods.depcode                                                             
  left OUTER join icd101 i1 on i1.code=v.pdx                                                                           
  left OUTER join pttype pt on pt.pttype=v.pttype 
  left outer join opdscreen oc on oc.vn=ods.vn   
  left outer join pt_walk pw on pw.walk_id = oc.walk_id  
  left outer join visit_type vt on vt.visit_type = o.visit_type
  
  #where v.vstdate between :date_start_text AND :date_end_text
  where v.vstdate between 20160401 AND 20160401
  AND v.pdx not between 'B20' AND 'B24'

  group by v.vn
  ORDER BY oc.vstdate,oc.vsttime desc;