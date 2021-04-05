class PrstFormsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @exp_forms = ExpForm.where(:region => current_user.identity, :state => ["prospecting", "pending"]) 
  end
   

   
  def show
    @prst_form = PrstForm.find(params[:id])
  end
   

   
  def new
    @prst_form = PrstForm.new
  end
   

   
  def create
    @prst_form = PrstForm.new(prst_form_params)
    #@prst_form.user = current_user
    if @prst_form.save
      redirect_to @prst_form
    else
      render :new
    end
  end
   

   
  def edit
    @prst_form = PrstForm.find(params[:id])
    @exp_form = @prst_form.exp_form
    arr = ["opening", "prospecting",  "pending",  "paying",  "constructing",  "visiting",  "completed"]
    @state = arr.index(@exp_form.state) + 1
  end
   

   
  def update
    @prst_form = PrstForm.find(params[:id])
    if @prst_form.update(prst_form_params)
      @exp_form = @prst_form.exp_form
      @exp_form.pend
      @exp_form.save
      redirect_to prst_forms_path
    else
      render :edit
    end
  end
   

   
  def destroy
    @prst_form = PrstForm.find(params[:id])
    @prst_form.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
      @prst_form = PrstForm.find(params[:id])
      @attachment_id = params[:number].to_i
      @attachment = @prst_form.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  

  private
    def prst_form_params
      params.require(:prst_form).permit( :title, :info , attachments_attributes: attachment_params , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

