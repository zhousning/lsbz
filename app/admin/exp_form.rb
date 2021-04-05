ActiveAdmin.register ExpForm  do

  permit_params  :name, :agtor, :idno, :contact, :email, :prj_name, :prj_address, :prj_attr, :prj_type, :east, :west, :south, :north, :cmp_type, :region, :area, :matter, :taxid, :bank, :account, :vat, :prs, :state

  menu label: Setting.exp_forms.label
  config.per_page = 20
  config.sort_order = "id_asc"

  
  filter :name, :label => Setting.exp_forms.name
  filter :agtor, :label => Setting.exp_forms.agtor
  filter :idno, :label => Setting.exp_forms.idno
  filter :contact, :label => Setting.exp_forms.contact
  filter :email, :label => Setting.exp_forms.email
  filter :prj_name, :label => Setting.exp_forms.prj_name
  filter :prj_address, :label => Setting.exp_forms.prj_address
  filter :prj_attr, :label => Setting.exp_forms.prj_attr
  filter :prj_type, :label => Setting.exp_forms.prj_type
  filter :east, :label => Setting.exp_forms.east
  filter :west, :label => Setting.exp_forms.west
  filter :south, :label => Setting.exp_forms.south
  filter :north, :label => Setting.exp_forms.north
  filter :cmp_type, :label => Setting.exp_forms.cmp_type
  filter :region, :label => Setting.exp_forms.region
  filter :area, :label => Setting.exp_forms.area
  filter :matter, :label => Setting.exp_forms.matter
  filter :taxid, :label => Setting.exp_forms.taxid
  filter :bank, :label => Setting.exp_forms.bank
  filter :account, :label => Setting.exp_forms.account
  filter :vat, :label => Setting.exp_forms.vat
  filter :prs, :label => Setting.exp_forms.prs
  filter :state, :label => Setting.exp_forms.state
  filter :created_at

  index :title=>Setting.exp_forms.label + "管理" do
    selectable_column
    id_column
    
    column Setting.exp_forms.name, :name
    column Setting.exp_forms.agtor, :agtor
    column Setting.exp_forms.idno, :idno
    column Setting.exp_forms.contact, :contact
    column Setting.exp_forms.email, :email
    column Setting.exp_forms.prj_name, :prj_name
    column Setting.exp_forms.prj_address, :prj_address
    column Setting.exp_forms.prj_attr, :prj_attr
    column Setting.exp_forms.prj_type, :prj_type
    column Setting.exp_forms.east, :east
    column Setting.exp_forms.west, :west
    column Setting.exp_forms.south, :south
    column Setting.exp_forms.north, :north
    column Setting.exp_forms.cmp_type, :cmp_type
    column Setting.exp_forms.region, :region
    column Setting.exp_forms.area, :area
    column Setting.exp_forms.matter, :matter
    column Setting.exp_forms.taxid, :taxid
    column Setting.exp_forms.bank, :bank
    column Setting.exp_forms.account, :account
    column Setting.exp_forms.vat, :vat
    column Setting.exp_forms.prs, :prs
    column Setting.exp_forms.state, :state

    column "创建时间", :created_at, :sortable=>:created_at do |f|
      f.created_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    column "更新时间", :updated_at do |f|
      f.updated_at.strftime('%Y-%m-%d %H:%M:%S')
    end
    actions
  end

  form do |f|
    f.inputs "添加" + Setting.exp_forms.label do
      
      f.input :name, :label => Setting.exp_forms.name 
      f.input :agtor, :label => Setting.exp_forms.agtor 
      f.input :idno, :label => Setting.exp_forms.idno 
      f.input :contact, :label => Setting.exp_forms.contact 
      f.input :email, :label => Setting.exp_forms.email 
      f.input :prj_name, :label => Setting.exp_forms.prj_name 
      f.input :prj_address, :label => Setting.exp_forms.prj_address 
      f.input :prj_attr, :label => Setting.exp_forms.prj_attr 
      f.input :prj_type, :label => Setting.exp_forms.prj_type 
      f.input :east, :label => Setting.exp_forms.east 
      f.input :west, :label => Setting.exp_forms.west 
      f.input :south, :label => Setting.exp_forms.south 
      f.input :north, :label => Setting.exp_forms.north 
      f.input :cmp_type, :label => Setting.exp_forms.cmp_type 
      f.input :region, :label => Setting.exp_forms.region 
      f.input :area, :label => Setting.exp_forms.area 
      f.input :matter, :label => Setting.exp_forms.matter 
      f.input :taxid, :label => Setting.exp_forms.taxid 
      f.input :bank, :label => Setting.exp_forms.bank 
      f.input :account, :label => Setting.exp_forms.account 
      f.input :vat, :label => Setting.exp_forms.vat 
      f.input :prs, :label => Setting.exp_forms.prs 
      f.input :state, :label => Setting.exp_forms.state 
    end
    f.actions
  end

  show :title=>Setting.exp_forms.label + "信息" do
    attributes_table do
      row "ID" do
        exp_form.id
      end
      
      row Setting.exp_forms.name do
        exp_form.name
      end
      row Setting.exp_forms.agtor do
        exp_form.agtor
      end
      row Setting.exp_forms.idno do
        exp_form.idno
      end
      row Setting.exp_forms.contact do
        exp_form.contact
      end
      row Setting.exp_forms.email do
        exp_form.email
      end
      row Setting.exp_forms.prj_name do
        exp_form.prj_name
      end
      row Setting.exp_forms.prj_address do
        exp_form.prj_address
      end
      row Setting.exp_forms.prj_attr do
        exp_form.prj_attr
      end
      row Setting.exp_forms.prj_type do
        exp_form.prj_type
      end
      row Setting.exp_forms.east do
        exp_form.east
      end
      row Setting.exp_forms.west do
        exp_form.west
      end
      row Setting.exp_forms.south do
        exp_form.south
      end
      row Setting.exp_forms.north do
        exp_form.north
      end
      row Setting.exp_forms.cmp_type do
        exp_form.cmp_type
      end
      row Setting.exp_forms.region do
        exp_form.region
      end
      row Setting.exp_forms.area do
        exp_form.area
      end
      row Setting.exp_forms.matter do
        exp_form.matter
      end
      row Setting.exp_forms.taxid do
        exp_form.taxid
      end
      row Setting.exp_forms.bank do
        exp_form.bank
      end
      row Setting.exp_forms.account do
        exp_form.account
      end
      row Setting.exp_forms.vat do
        exp_form.vat
      end
      row Setting.exp_forms.prs do
        exp_form.prs
      end
      row Setting.exp_forms.state do
        exp_form.state
      end

      row "创建时间" do
        exp_form.created_at.strftime('%Y-%m-%d %H:%M:%S')
      end
      row "更新时间" do
        exp_form.updated_at.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end

end
