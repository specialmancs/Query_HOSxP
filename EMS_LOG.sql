select distinct v.vn,oc.vstdate,oc.vsttime,p.hn,concat(p.pname,p.fname," ",p.lname)as ptname,p.cid,
  vt.visit_type_name,pw.`name` as pt_walk_name,ems.revisit48hr,ems.admit_2hr,
  oc.cc,oc.hpi,oc.pmh,erl.er_list,ept.`name` as er_pt_type,eme.`name` as emergency,ems.trauma,
  act.er_accident_type_name as accident_type,oc.bpd,oc.bps,oc.bw,oc.hr,oc.pe,oc.pulse,oc.rr,
  ems.gcs_e,ems.gcs_v,ems.gcs_m,ems.pupil_l,ems.pupil_r,ems.o2sat,apt.accident_person_type_name as person_type,
	alc.accident_alcohol_type_name as alcohol,drug.accident_drug_type_name as drug,airway.accident_airway_type_name as airway,
	bleed.accident_bleed_type_name as bleed,belt.accident_belt_type_name as belt,helmet.accident_helmet_type_name as helmet,
	splint.accident_splint_type_name as splint,fluid.accident_fluid_type_name as fluid,
	hos1.name as refer_hosptype,hos2.name as refer_sender,tran.accident_transport_type_name as transport_type,
  ems.accident_note_text,v.pdx,k.department,GROUP_CONCAT(oq.doctor_list_text) as doctor_list
                                                                               
  from er_nursing_detail ems 
	LEFT OUTER JOIN er_regist erl on erl.vn = ems.vn
	LEFT OUTER JOIN ovst_doctor_sign ods on ods.vn = erl.vn
  LEFT OUTER JOIN er_emergency_type eme on 	eme.er_emergency_type = erl.er_emergency_type
  LEFT OUTER JOIN er_pt_type ept on 	ept.er_pt_type = erl.er_pt_type
  LEFT OUTER JOIN er_period peri on 	peri.er_period = erl.er_period																																										
  left OUTER join vn_stat v on v.vn=erl.vn 
  left outer join ovst as o on o.vn = erl.vn                                                                            
  left OUTER join patient p on p.hn=v.hn                                                                               
  left OUTER join kskdepartment k on k.depcode = ods.depcode                                                             
  left OUTER join icd101 i1 on i1.code=v.pdx                                                                           
  left outer join opdscreen oc on oc.vn=ods.vn   
  left outer join pt_walk pw on pw.walk_id = oc.walk_id  
  left outer join visit_type vt on vt.visit_type = o.visit_type
  left outer join ovst_seq oq on oq.vn = erl.vn
LEFT OUTER JOIN er_accident_type act on act.er_accident_type_id = ems.er_accident_type_id
LEFT OUTER JOIN accident_person_type apt on apt.accident_person_type_id = ems.accident_person_type_id
LEFT OUTER JOIN accident_alcohol_type alc on alc.accident_alcohol_type_id = ems.accident_alcohol_type_id
LEFT OUTER JOIN accident_drug_type drug on drug.accident_drug_type_id = ems.accident_drug_type_id
LEFT OUTER JOIN accident_airway_type airway on airway.accident_airway_type_id = ems.accident_airway_type_id
LEFT OUTER JOIN accident_bleed_type bleed on bleed.accident_bleed_type_id = ems.accident_bleed_type_id
LEFT OUTER JOIN accident_belt_type belt on belt.accident_belt_type_id = ems.accident_belt_type_id
LEFT OUTER JOIN accident_helmet_type helmet on helmet.accident_helmet_type_id = ems.accident_helmet_type_id
LEFT OUTER JOIN accident_splint_type splint on splint.accident_splint_type_id = ems.accident_splint_type_id
LEFT OUTER JOIN accident_fluid_type fluid on fluid.accident_fluid_type_id = ems.accident_fluid_type_id
LEFT OUTER JOIN accident_transport_type tran on tran.accident_transport_type_id = ems.accident_transport_type_id
LEFT OUTER JOIN er_refer_hosptype ret on ret.er_refer_hosptype_id = ems.er_refer_hosptype_id
LEFT OUTER JOIN hospcode hos1 on hos1.hospcode = ems.er_refer_hosptype_id
LEFT OUTER JOIN hospcode hos2 on hos2.hospcode = ems.er_refer_sender_id

  #where v.vstdate between :date_start_text AND :date_end_text
  where v.vstdate between 20160401 AND 20160401
  AND v.pdx not between 'B20' AND 'B24'

  group by v.vn
  ORDER BY oc.vstdate,oc.vsttime desc;