class CreateExpForms < ActiveRecord::Migration
  def change
    create_table :exp_forms do |t|
    
      t.string :name,  null: false, default: Setting.systems.default_str
    
      t.string :agtor,  null: false, default: Setting.systems.default_str
    
      t.string :idno,  null: false, default: Setting.systems.default_str
    
      t.string :contact,  null: false, default: Setting.systems.default_str
    
      t.string :email,  null: false, default: Setting.systems.default_str
    
      t.string :prj_name,  null: false, default: Setting.systems.default_str
    
      t.string :prj_address,  null: false, default: Setting.systems.default_str
    
      t.string :prj_attr,  null: false, default: Setting.systems.default_str
    
      t.string :prj_type,  null: false, default: Setting.systems.default_str
    
      t.string :east,  null: false, default: Setting.systems.default_str
    
      t.string :west,  null: false, default: Setting.systems.default_str
    
      t.string :south,  null: false, default: Setting.systems.default_str
    
      t.string :north,  null: false, default: Setting.systems.default_str
    
      t.string :cmp_type,  null: false, default: Setting.systems.default_str
    
      t.string :region,  null: false, default: Setting.systems.default_str
    
      t.float :area,  null: false, default: Setting.systems.default_num 
    
      t.string :matter,  null: false, default: Setting.systems.default_str
    
      t.string :taxid,  null: false, default: Setting.systems.default_str
    
      t.string :bank,  null: false, default: Setting.systems.default_str
    
      t.string :account,  null: false, default: Setting.systems.default_str
    
      t.string :vat,  null: false, default: Setting.systems.default_str
    
      t.string :prs,  null: false, default: Setting.systems.default_str
    
      t.string :state,  null: false, default: Setting.systems.default_str
    

      t.string :qr_code_uid
    

    

    

      t.timestamps null: false
    end
  end
end
