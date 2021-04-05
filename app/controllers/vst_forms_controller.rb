class VstFormsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @exp_forms = ExpForm.where(:region => current_user.identity, :state => ["visiting"]) 
  end
   

   
  def show
    @vst_form = VstForm.find(params[:id])
  end
   

   
  def new
    @vst_form = VstForm.new
    
  end
   

   
  def create
    @vst_form = VstForm.new(vst_form_params)
    #@vst_form.user = current_user
    if @vst_form.save
      redirect_to @vst_form
    else
      render :new
    end
  end
   

   
  def edit
    @vst_form = VstForm.find(params[:id])
    @exp_form = @vst_form.exp_form
    @aprv_form = @exp_form.aprv_form
    @prst_form = @exp_form.prst_form
    @pay_form = @exp_form.pay_form
    @cstr_form = @exp_form.cstr_form
    arr = ["opening", "prospecting",  "pending",  "paying",  "constructing",  "visiting",  "completed"]
    @state = arr.index(@exp_form.state) + 1
  end
   

   
  def update
    @vst_form = VstForm.find(params[:id])
    if @vst_form.update(vst_form_params)
      @exp_form = @vst_form.exp_form
      @exp_form.complete
      @exp_form.save
      redirect_to vst_form_path(@vst_form) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @vst_form = VstForm.find(params[:id])
    @vst_form.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
      @vst_form = VstForm.find(params[:id])
      @attachment_id = params[:number].to_i
      @attachment = @vst_form.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  

  private
    def vst_form_params
      params.require(:vst_form).permit( :title, :info , attachments_attributes: attachment_params , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

