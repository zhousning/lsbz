class CstrFormsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @exp_forms = ExpForm.where(:region => current_user.identity, :state => ["constructing"]) 
  end
   

   
  def show
    @cstr_form = CstrForm.find(params[:id])
  end
   

   
  def new
    @cstr_form = CstrForm.new
    
  end
   

   
  def create
    @cstr_form = CstrForm.new(cstr_form_params)
    #@cstr_form.user = current_user
    if @cstr_form.save
      redirect_to @cstr_form
    else
      render :new
    end
  end
   

   
  def edit
    @cstr_form = CstrForm.find(params[:id])
    @exp_form = @cstr_form.exp_form
    @aprv_form = @exp_form.aprv_form
    @prst_form = @exp_form.prst_form
    @pay_form = @exp_form.pay_form
  end
   

   
  def update
    @cstr_form = CstrForm.find(params[:id])
    if @cstr_form.update(cstr_form_params)
      @exp_form = @cstr_form.exp_form
      @exp_form.visit
      @exp_form.save
      redirect_to cstr_form_path(@cstr_form) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @cstr_form = CstrForm.find(params[:id])
    @cstr_form.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
      @cstr_form = CstrForm.find(params[:id])
      @attachment_id = params[:number].to_i
      @attachment = @cstr_form.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  

  private
    def cstr_form_params
      params.require(:cstr_form).permit( :title, :info , attachments_attributes: attachment_params , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

