class InputItemsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  before_filter :is_can_use?, :only => [:index]
  #load_and_authorize_resource

  def index
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @ware_house.uploading
    @input_items = @ware_house.input_items.all
    gon.ware_house = @ware_house.id
  end

  def current_ctg_mtrl
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @inputs = @ware_house.input_items
    unless @inputs.blank?
      mtrl_arr = []
      @inputs.each do |input|
        ctg_mtrl = input.ctg_mtrl
        mtrl_arr << ctg_mtrl.id
      end
      @ctg_mtrls = ctg_mtrl_all(mtrl_arr)
    else
      @ctg_mtrls = ctg_mtrl_all
    end
  end

  def ctg_mtrl_all(ctg_ids = [])
    @ctg_mtrls = []
    ctg_frsts = current_user.ctg_frsts
    ctg_frsts.each do |frst|
      ctg_secds = frst.ctg_secds
      ctg_secds.each do |secd|
        secd.ctg_mtrls.each do |mtrl|
          @ctg_mtrls << mtrl unless ctg_ids.include?(mtrl.id)
        end
      end
    end
    @ctg_mtrls
  end

  def select_ctg_mtrl
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    ctg_mtrl_ids = params[:selections].split(",")
    unless ctg_mtrl_ids.empty?
      @ctg_mtrls = CtgMtrl.find(ctg_mtrl_ids)
      InputItem.transaction do
        @ctg_mtrls.each do |ctg_mtrl|
          InputItem.create(:ware_house => @ware_house, :ctg_mtrl => ctg_mtrl)
        end
      end
    end
    redirect_to ware_house_input_items_path(@ware_house)
  end

  def input_item_create
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @inputs = @ware_house.input_items
    nums = params[:nums]
    objs = nums.split("$")
    begin
      InputItem.transaction do
        objs.each do |obj|
          obj_arr = obj.split(",")
          id = obj_arr[0]
          input = @inputs.find(id)

          price_count = obj_arr[1].split("-")
          unit_price = price_count[0].to_f
          count = price_count[1].to_i
          total_price = unit_price*count

          input.update_attributes!(:unit_price => unit_price, :count => count, :total_price => total_price)
        end
      end
    rescue
      flash[:warning] = "???????????????"
      redirect_to ware_house_input_items_path(@ware_house)
      return
    end
    redirect_to ware_house_path(@ware_house)
  end

  def ware_item
    @ware_houses = current_user.ware_houses
    @input_items = []
    @ware_houses.each do |ware|
      ware.input_items.each do|item|
        @input_items << item
      end
    end
  end

  #def search
  #  @ware_house_ids = current_user.ware_houses.ids

  #  if params[:search].present?
  #    #@input_items = InputItem.search params[:search], page: params[:page], per_page: Setting.site_themes.max_page
  #  end
  #end
   

   
  def show
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @input_item = @ware_house.input_items.find(params[:id])
  end
   

   
  def new
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @input_item = InputItem.new
    gon.ctg_mtr = "" 
  end
   

   
  def create
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @input_item = InputItem.new(cal_price(input_item_params))
    @ctg_mtrl = CtgMtrl.find(params[:ctg_mtrl])
    @input_item.ctg_mtrl = @ctg_mtrl
    @input_item.ware_house = @ware_house
    if @input_item.save
      redirect_to ware_house_input_items_path(@ware_house)
    else
      render :new
    end
  end

   
  def edit
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @input_item = @ware_house.input_items.find(params[:id])
    gon.ctg_mtr = @input_item.ctg_mtrl.id.to_s
  end
   

   
  def update
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @input_item = @ware_house.input_items.find(params[:id])
    @ctg_mtrl = CtgMtrl.find(params[:ctg_mtrl])
    @input_item.ctg_mtrl = @ctg_mtrl

    if @input_item.update(cal_price(input_item_params))
      redirect_to ware_house_input_items_path(@ware_house)
    else
      render :edit
    end
  end
   

   
  def destroy
    @ware_house = current_user.ware_houses.find(params[:ware_house_id])
    @input_item = @ware_house.input_items.find(params[:id])
    @input_item.destroy
    @ware_house.uploading if @ware_house.input_items.blank?
    redirect_to :action => :index
  end
   

  

  

  private
    def input_item_params
      params.require(:input_item).permit( :unit_price, :count, :total_price)
    end
  
    def cal_price(input_item_params)
      output_item_params = Hash.new
      output_item_params[:unit_price] = input_item_params[:unit_price]
      output_item_params[:count] = input_item_params[:count]
      output_item_params[:total_price] = input_item_params[:unit_price].to_f*input_item_params[:count].to_f
      output_item_params
    end
   
    def is_can_use?
      @ware_house = current_user.ware_houses.find(params[:ware_house_id])
      unless @ware_house.state != Setting.ware_houses.completed && @ware_house.state != Setting.ware_houses.canceled 
        redirect_to ware_houses_path 
      end
    end

  
  
end

