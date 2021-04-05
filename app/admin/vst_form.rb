ActiveAdmin.register VstForm  do

  permit_params  :title, :info

  menu label: Setting.vst_forms.label
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :title, :label => Setting.vst_forms.title
  filter :info, :label => Setting.vst_forms.info
  filter :created_at

  index :title=>Setting.vst_forms.label + "管理" do
    selectable_column
    id_column
    
    column Setting.vst_forms.title, :title
    column Setting.vst_forms.info, :info

    column "创建时间", :created_at, :sortable=>:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间", :updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    actions
  end

  form do |f|
    f.inputs "添加" + Setting.vst_forms.label do
      
      f.input :title, :label => Setting.vst_forms.title 
      f.input :info, :label => Setting.vst_forms.info 
    end
    f.actions
  end

  show :title=>Setting.vst_forms.label + "信息" do
    attributes_table do
      row "ID" do
        vst_form.id
      end
      
      row Setting.vst_forms.title do
        vst_form.title
      end
      row Setting.vst_forms.info do
        vst_form.info
      end

      row "创建时间" do
        vst_form.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        vst_form.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

end
