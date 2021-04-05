class CreateVstForms < ActiveRecord::Migration
  def change
    create_table :vst_forms do |t|
    
      t.string :title,  null: false, default: Setting.systems.default_str
    
      t.text :info
    

    

    

    
      t.references :exp_form
    

      t.timestamps null: false
    end
  end
end
