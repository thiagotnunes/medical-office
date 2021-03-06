Factory.sequence :telephone_label do |n|
  "#{Forgery::Name.telephone_label} #{n + (rand * 10)}"
end

Factory.sequence :address_label do |n|
  "#{Forgery::Name.address_label} #{n + (rand * 10)}"
end

Factory.sequence :patient_history_label do |n|
  "#{Forgery::Name.patient_history_label} #{n + (rand * 10)}"
end

Factory.sequence :patient_record do |n|
  n
end

Factory.define :patient do |p|
  p.record Factory.next(:patient_record)
  p.name Forgery::Name.full_name
  p.cpf Forgery::Brazil.valid_cpf
  p.rg Forgery::Brazil.valid_rg
  p.sex Forgery::Personal.gender
  p.color Forgery::Personal.color
  p.birth_date Date.today
  p.profession Forgery::Name.profession
  p.city Forgery::Address.city
  p.state Forgery::Address.state
  p.country Forgery::Address.country
  p.fathers_name "#{Forgery::Name.male_first_name} #{Forgery::Name.last_name}"
  p.mothers_name "#{Forgery::Name.female_first_name} #{Forgery::Name.last_name}"
  p.forwarded_by Forgery::Name.full_name
  p.marital_status Forgery::Personal.marital_status
  p.health_insurance_number Forgery::Basic.number
  p.association :health_insurance, :factory => :health_insurance
  p.first_appointment Date.today
  p.addresses do 
    [Factory.build(:address)]
  end
  p.telephones do
    [Factory.build(:telephone)]
  end
  p.patient_surgeries do
    [Factory.build(:patient_surgery)]
  end
end

Factory.define :plastic_surgery_patient, :parent => :patient do |psp|
  psp.type "PlasticSurgeryPatient"
  psp.association :patient_clinical_information, :factory => :patient_clinical_information
end

Factory.define :occupational_therapy_patient, :parent => :patient do |otp|
  otp.type "OccupationalTherapyPatient"
  otp.association :patient_therapy_information, :factory => :patient_therapy_information
end

Factory.define :dermatology_patient, :parent => :patient do |dp|
  dp.type "DermatologyPatient"
  dp.main_complaint Forgery::Basic.text
end

Factory.define :evolution do |e|
  e.attendance_date Date.today
  e.description Forgery::Basic.text
end

Factory.define :health_insurance do |hi|
  hi.sequence(:name) { |n| "#{Forgery::Name.company_name} #{n}" }
end

Factory.define :address do |a|
  a.location Forgery::Address.street_address
  a.complement Forgery::Address.street_number
  a.address_label { |al| al.association(:address_label, :label => Factory.next(:address_label)) }
end

Factory.define :telephone do |t|
  t.number "%010d" % Forgery::Basic.number
  t.telephone_label { |tl| tl.association(:telephone_label, :label => Factory.next(:telephone_label)) }
end

Factory.define :patient_history do |ph|
  ph.history Forgery::LoremIpsum.text
  ph.patient_history_label { |phl| phl.association(:patient_history_label) }
end

Factory.define :patient_clinical_information do |pch|
  pch.clazz "Class"
  pch.appointment_reason Forgery::LoremIpsum.text
  pch.injury_exists_from Date.today
  pch.injury_side "Right"
  pch.injury_appraiser_physician Forgery::Name.full_name
  pch.evolution_time Forgery::Basic.number
  pch.physical_exam Forgery::LoremIpsum.text
  pch.physical_exam_date Date.today
  pch.diagnostics_hypothesis Forgery::LoremIpsum.text
end

Factory.define :patient_therapy_information do |pti|
  pti.diagnosis "Diagnosis of the patient"
  pti.injury_time Forgery::Basic.number
  pti.injury_appraiser_physician Forgery::Name.full_name
  pti.main_complaint Forgery::LoremIpsum.text
  pti.disease_history Forgery::LoremIpsum.text
  pti.impaired_limb "Left Arm"
  pti.dominance Forgery::LoremIpsum.text
  pti.adm Forgery::LoremIpsum.text
  pti.fm Forgery::LoremIpsum.text
  pti.sensibility Forgery::LoremIpsum.text
  pti.aspect Forgery::LoremIpsum.text
  pti.fo Forgery::LoremIpsum.text
  pti.circumference Forgery::LoremIpsum.text
  pti.avds Forgery::LoremIpsum.text
  pti.dnpm Forgery::LoremIpsum.text
end

Factory.define :patient_surgery do |ps|
  ps.evaluations_results Forgery::LoremIpsum.text
  ps.indicated_conduct "Conduct"
  ps.cid "1234567890"
  ps.surgery_performed "Surgery"
  ps.surgery_date Date.today
  ps.surgery_performed_at "Hospital"
  ps.surgery_anesthethist Forgery::Name.full_name
  ps.surgery_description Forgery::LoremIpsum.text
  ps.po_imediate_result "Result of the surgery"
  ps.intercurrences Forgery::LoremIpsum.text
  ps.pathology_material "Pathology material"
  ps.pathology_result "Pathology result"
  ps.diagnosis "Diagnosis"
end

Factory.define :patient_history_label do |ph|
  ph.label Factory.next(:patient_history_label)
end

Factory.define :telephone_label do |tl|
  tl.label Factory.next(:telephone_label)
end

Factory.define :address_label do |al|
  al.label Factory.next(:address_label)
end
