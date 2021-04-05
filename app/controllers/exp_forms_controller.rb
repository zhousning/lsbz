class ExpFormsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @exp_forms = ExpForm.all
  end

  def opening
    @exp_forms = ExpForm.where(:region => current_user.identity) 
  end
   
  def opening_show
    @exp_form = ExpForm.find(params[:id])
  end

  def prospecting
    @exp_form = ExpForm.find(params[:id])
    @exp_form.prospect
    @exp_form.build_prst_form
    @exp_form.build_aprv_form
    @exp_form.build_pay_form
    @exp_form.build_cstr_form
    @exp_form.build_vst_form
    @exp_form.save
    redirect_to opening_show_exp_form_path(@exp_form)
  end

  

   
  def show
    @exp_form = ExpForm.find(params[:id])
    arr = ["opening", "prospecting",  "pending",  "paying",  "constructing",  "visiting",  "completed"]
    @state = arr.index(@exp_form.state) + 1
  end
   

   
  def new
    @exp_form = ExpForm.new
    
  end
   

  def exp_msg
    @exp_form = ExpForm.find(params[:id])
  end

   
  def create
    @exp_form = ExpForm.new(exp_form_params)
    if @exp_form.save
      link = Rails.application.routes.url_helpers.exp_form_url(:host => Setting.systems.host, :id => @exp_form.id)
      #qr_code_img = RQRCode::QRCode.new(link).to_img.resize(300, 300)
      qr_code_img = RQRCode::QRCode.new(link).as_png
      @exp_form.update(:qr_code => qr_code_img.to_string)
      redirect_to exp_msg_exp_form_path(@exp_form)
    else
      render :new
    end
  end
   

   
  def edit
    @exp_form = ExpForm.find(params[:id])
  end
   

   
  def update
    @exp_form = ExpForm.find(params[:id])
    if @exp_form.update(exp_form_params)
      redirect_to exp_form_path(@exp_form) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @exp_form = ExpForm.find(params[:id])
    @exp_form.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
      @exp_form = ExpForm.find(params[:id])
      @attachment_id = params[:number].to_i
      @attachment = @exp_form.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  

  private
    def exp_form_params
      params.require(:exp_form).permit( :name, :agtor, :idno, :contact, :email, :prj_name, :prj_address, :prj_attr, :prj_type, :east, :west, :south, :north, :cmp_type, :region, :area, :matter, :taxid, :bank, :account, :vat, :prs, :state , attachments_attributes: attachment_params)
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

