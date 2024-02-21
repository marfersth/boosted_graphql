# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



group_1 = Group.create(name: 'group_1')
group_2 = Group.create(name: 'group_2')
company_1 = Business::Company.create(name: 'company_1')
company_2 = Business::Company.create(name: 'company_2')

# subject_1 = Subject.create(update_type: 'note', data: 'data_subject_1', business_company_datum: company_1)
# Permission.create(permissionable: subject_1, user: user, group: group_1)
# attribute_1_1 = Property.create(subject: subject_1, key: :number, value: 2)
# Permission.create(permissionable: attribute_1_1, user: user, group: group_1)
# attribute_1_2 = Property.create(subject: subject_1, key: :date, value: Time.new(2000))
# Permission.create(permissionable: attribute_1_2, user: user, group: group_1)
# attribute_1_3 = Property.create(subject: subject_1, key: :bool, value: true)
# Permission.create(permissionable: attribute_1_3, user: user, group: group_1)
#
# subject_2 = Subject.create(update_type: 'note', data: 'data_subject_1', business_company_datum: company_1)
# Permission.create(permissionable: subject_2, user: user, group: group_1)
# attribute_2_1 = Property.create(subject: subject_2, key: :number, value: 1)
# Permission.create(permissionable: attribute_2_1, user: user, group: group_1)
# attribute_2_2 = Property.create(subject: subject_2, key: :date, value: Time.new(2002))
# Permission.create(permissionable: attribute_2_2, user: user, group: group_1)
# attribute_2_3 = Property.create(subject: subject_2, key: :bool, value: false)
# Permission.create(permissionable: attribute_2_3, user: user, group: group_1)

####################################################################################################################################

# subject_1 = Subject.create(update_type: 'note', data: 'data_subject_1', business_company_datum: company_1)
# subject_1.update!(created_at: Time.new(2000))
# Permission.create(permissionable: subject_1, user: user, group: group_1)
# Permission.create(permissionable: subject_1, user: user, group: group_2)
# attribute_1_1 = Property.create(subject: subject_1, key: :number, value: 1)
# Permission.create(permissionable: attribute_1_1, user: user, group: group_1)
# attribute_1_2 = Property.create(subject: subject_1, key: :number, value: 2)
# Permission.create(permissionable: attribute_1_2, user: user, group: group_2)
#
# subject_2 = Subject.create(update_type: 'note', data: 'data_subject_2', business_company_datum: company_2)
# subject_2.update!(created_at: Time.new(2001))
# Permission.create(permissionable: subject_2, user: user, group: group_1)
# Permission.create(permissionable: subject_2, user: user, group: group_2)
# attribute_2_1 = Property.create(subject: subject_2, key: :date, value: Time.new(2000))
# Permission.create(permissionable: attribute_2_1, user: user, group: group_1)
# attribute_2_2 = Property.create(subject: subject_2, key: :date, value: Time.new(2001))
# Permission.create(permissionable: attribute_2_2, user: user, group: group_1)
# attribute_2_3 = Property.create(subject: subject_2, key: :name, value: 'some name')
# Permission.create(permissionable: attribute_2_3, user: user, group: group_1)
# attribute_2_2 = Property.create(subject: subject_2, key: :date, value: Time.new(2002))
# Permission.create(permissionable: attribute_2_2, user: user, group: group_2)

####################################################################################################################################

for i in 0..49_999
  puts "subject #{i}"
  subjects = Subject.insert_all(
    [{data: "data_subject_1-#{i}", business_company_id: company_1.id, created_at: Time.now, updated_at: Time.now},
     {data: "data_subject_2-#{i}", business_company_id: company_2.id, created_at: Time.now, updated_at: Time.now}],
    returning: :id)
  Permission.insert_all(
    [{permissionable_id: subjects[0]['id'], permissionable_type: 'Subject', group_id: group_1.id, created_at: Time.now, updated_at: Time.now},
     {permissionable_id: subjects[1]['id'], permissionable_type: 'Subject', group_id: group_1.id, created_at: Time.now, updated_at: Time.now},
     {permissionable_id: subjects[1]['id'], permissionable_type: 'Subject', group_id: group_2.id, created_at: Time.now, updated_at: Time.now}])
  for i_1 in 0..10
    # puts "property #{i_1}"
    properties = Property.insert_all(
      [{subject_id: subjects[0]['id'], key: :date, value: Time.new(i+i_1), created_at: Time.now, updated_at: Time.now},
       {subject_id: subjects[0]['id'], key: :number, value: i+i_1, created_at: Time.now, updated_at: Time.now},
       {subject_id: subjects[0]['id'], key: :name, value: "note12_#{i+i_1}", created_at: Time.now, updated_at: Time.now},
       {subject_id: subjects[0]['id'], key: :name, value: "note2_#{i+i_1}", created_at: Time.now, updated_at: Time.now},
       {subject_id: subjects[1]['id'], key: :name, value: "document12_#{i+i_1}", created_at: Time.now, updated_at: Time.now},
       {subject_id: subjects[1]['id'], key: :name, value: "document2_#{i+i_1}", created_at: Time.now, updated_at: Time.now},
       {subject_id: subjects[0]['id'], key: :bool, value: true, created_at: Time.now, updated_at: Time.now},
       {subject_id: subjects[1]['id'], key: :bool, value: false, created_at: Time.now, updated_at: Time.now}],
      returning: :id)
    Permission.insert_all(
      [{permissionable_id: properties[0]['id'], permissionable_type: 'Property', group_id: group_1.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[1]['id'], permissionable_type: 'Property', group_id: group_1.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[2]['id'], permissionable_type: 'Property', group_id: group_1.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[2]['id'], permissionable_type: 'Property', group_id: group_2.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[3]['id'], permissionable_type: 'Property', group_id: group_2.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[4]['id'], permissionable_type: 'Property', group_id: group_1.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[4]['id'], permissionable_type: 'Property', group_id: group_2.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[5]['id'], permissionable_type: 'Property', group_id: group_2.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[6]['id'], permissionable_type: 'Property', group_id: group_1.id, created_at: Time.now, updated_at: Time.now},
       {permissionable_id: properties[7]['id'], permissionable_type: 'Property', group_id: group_1.id, created_at: Time.now, updated_at: Time.now}])
  end
end
