# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.create(:name => Setting.roles.super_admin)

admin_permissions = Permission.create(:name => Setting.permissions.super_admin, :subject_class => Setting.admins.class_name, :action => "manage")

role.permissions << admin_permissions

user = User.new(:phone => Setting.admins.phone, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)
user.save!

user.roles = []
user.roles << role


AdminUser.create!(:phone => Setting.admins.phone, :email => Setting.admins.email, :password => Setting.admins.password, :password_confirmation => Setting.admins.password)

User.create!(:phone => "15763703188", :password => "15763703188", :password_confirmation => "15763703188")

lssw = User.create!(:phone => "lssw", :password => "lssw123", :password_confirmation => "lssw123", :identity => Setting.roles.lssw)
yzsw = User.create!(:phone => "yzsw", :password => "yzsw123", :password_confirmation => "yzsw123" , :identity =>  Setting.roles.yzsw)
jxsw = User.create!(:phone => "jxsw", :password => "jxsw123", :password_confirmation => "jxsw123" , :identity =>  Setting.roles.jxsw)
zcsw = User.create!(:phone => "zcsw", :password => "zcsw123", :password_confirmation => "zcsw123" , :identity =>  Setting.roles.zcsw)
wssw = User.create!(:phone => "wssw", :password => "wssw123", :password_confirmation => "wssw123" , :identity =>  Setting.roles.wssw)
