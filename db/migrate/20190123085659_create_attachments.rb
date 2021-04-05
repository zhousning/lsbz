class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.timestamps null: false

      t.string :file,  null: false, default: ""
      t.references :exp_form
      t.references :prst_form
      t.references :aprv_form
      t.references :pay_form
      t.references :cstr_form
      t.references :cstr_form
      t.references :vst_form
    end
  end
end
