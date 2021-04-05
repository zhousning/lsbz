class AprvFormsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @exp_forms = ExpForm.where(:region => current_user.identity, :state => ["pending", "paying"]) 
  end
   

   
  def show
    @aprv_form = AprvForm.find(params[:id])
  end
   

   
  def new
    @aprv_form = AprvForm.new
    
  end
   

   
  def create
    @aprv_form = AprvForm.new(aprv_form_params)
    #@aprv_form.user = current_user
    if @aprv_form.save
      redirect_to @aprv_form
    else
      render :new
    end
  end
   

   
  def edit
    @aprv_form = AprvForm.find(params[:id])
    @exp_form = @aprv_form.exp_form
    @prst_form = @exp_form.prst_form
  end
   

   
  def update
    @aprv_form = AprvForm.find(params[:id])
    if @aprv_form.update(aprv_form_params)
      @exp_form = @aprv_form.exp_form
      @exp_form.pay
      @exp_form.save
      redirect_to aprv_form_path(@aprv_form) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @aprv_form = AprvForm.find(params[:id])
    @aprv_form.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
      @aprv_form = AprvForm.find(params[:id])
      @attachment_id = params[:number].to_i
      @attachment = @aprv_form.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  

  private
    def aprv_form_params
      params.require(:aprv_form).permit( :title, :info , attachments_attributes: attachment_params , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

