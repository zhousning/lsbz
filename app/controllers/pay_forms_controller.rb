class PayFormsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #load_and_authorize_resource

   
  def index
    @exp_forms = ExpForm.where(:region => current_user.identity, :state => ["paying"]) 
  end
   

   
  def show
    @pay_form = PayForm.find(params[:id])
  end
   

   
  def new
    @pay_form = PayForm.new
    
  end
   

   
  def create
    @pay_form = PayForm.new(pay_form_params)
    #@pay_form.user = current_user
    if @pay_form.save
      redirect_to @pay_form
    else
      render :new
    end
  end
   

   
  def edit
    @pay_form = PayForm.find(params[:id])
    @exp_form = @pay_form.exp_form
    @aprv_form = @exp_form.aprv_form
    @prst_form = @exp_form.prst_form
    arr = ["opening", "prospecting",  "pending",  "paying",  "constructing",  "visiting",  "completed"]
    @state = arr.index(@exp_form.state) + 1
  end
   

   
  def update
    @pay_form = PayForm.find(params[:id])
    if @pay_form.update(pay_form_params)
      @exp_form = @pay_form.exp_form
      @exp_form.construct
      @exp_form.save
      redirect_to pay_form_path(@pay_form) 
    else
      render :edit
    end
  end
   

   
  def destroy
    @pay_form = PayForm.find(params[:id])
    @pay_form.destroy
    redirect_to :action => :index
  end
   

  
    def download_attachment 
      @pay_form = PayForm.find(params[:id])
      @attachment_id = params[:number].to_i
      @attachment = @pay_form.attachments[@attachment_id]

      if @attachment
        send_file File.join(Rails.root, "public", URI.decode(@attachment.file_url)), :type => "application/force-download", :x_sendfile=>true
      end
    end
  

  

  private
    def pay_form_params
      params.require(:pay_form).permit( :title, :info , attachments_attributes: attachment_params , enclosures_attributes: enclosure_params)
    end
  
    def enclosure_params
      [:id, :file, :_destroy]
    end
  
  
    def attachment_params
      [:id, :file, :_destroy]
    end
  
  
end

