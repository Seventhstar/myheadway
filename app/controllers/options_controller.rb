class OptionsController < ApplicationController
  before_action :logged_in_user
  include OptionsHelper
  
  respond_to :json

  def index
    @items = option_model.order(:id)
    @item = option_model.new
    render json: @items
  end

  def create
    @items = option_model.order(:name)  
    respond_with(@item = option_model.create(options_params))

    # @item  = option_model.new(options_params)
    # if @item.save
    # else
      # respond_to do |format|
        # format.json { render json: @item.errors, status: :unprocessable_entity }
      # end
    # end
  end

  def edit
    @page = params[:options_page]
    @page ||= "books"    
    @item  = option_model.new
    @items = option_model.order(:id)
  end

  def destroy
    @item = option_model.find(params[:id])
    @item.destroy
  end  

  private
    def options_params
      i = option_model.model_name.singular
      params.require(i).permit(:name, :actual)
    end

    def option_model
      page = params[:options_page]
      page ||= "books"
      page.classify.constantize
    end
end
