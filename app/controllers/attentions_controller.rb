class AttentionsController < ApplicationController
  before_action :set_attention, only: [:show, :edit, :update, :destroy]

  def index
    cat_ids = search_ids = act_ids = auth_ids = all_ids = Attention.all.ids
    @only_actual = params[:only_actual].nil? ? true : params[:only_actual]=='true'
    params.delete_if{|k,v| v=='' || v=='0' || k=='_' }
    cat_ids   = AttnCat.find(params[:attn_cat_id]).attentions.ids if !params[:attn_cat_id].nil?
    
    act_ids = Attention.where(actual: true).ids if @only_actual
    auth_ids = Attention.where(author_id: params[:author_id]).ids if !params[:author_id].nil?
    search_ids  = Attention.where('name like ? or description like ?',
      '%'+params[:search]+'%','%'+params[:search]+'%').ids if !params[:search].nil?
    ids = cat_ids & search_ids & all_ids & act_ids & auth_ids
    @attentions = Attention.where('id in (?)', ids).order(created_at: :desc).paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @attention = Attention.new
    @user = current_user.id
    @actual = true
  end

  def edit
    @user = @attention.user_id
    @actual = @attention.actual
  end

  def create
    @attention = Attention.new(attention_params)

    respond_to do |format|
      if @attention.save
        format.html { redirect_to attentions_url, notice: 'Attention was successfully created.' }
        format.json { render action: 'show', status: :created, location: @attention }
      else
        format.html { render action: 'new' }
        format.json { render json: @attention.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attention.update(attention_params)
        format.html { redirect_to attentions_url, notice: 'Attention was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attention.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attention.destroy
    respond_to do |format|
      format.html { redirect_to attentions_url }
      format.json { head :no_content }
    end
  end

  private
    def set_attention
      @attention = Attention.find(params[:id])
    end

    def attention_params
      params.require(:attention).permit(:name, :user_id, :description, :src_url, :img_url, :attn_cat_id, :actual, :author_id)
    end
end
