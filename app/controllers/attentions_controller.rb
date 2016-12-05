class AttentionsController < ApplicationController
  before_action :set_attention, only: [:show, :edit, :update, :destroy]

  # GET /attentions
  # GET /attentions.json
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

  # GET /attentions/1
  # GET /attentions/1.json
  def show
  end

  # GET /attentions/new
  def new
    @attention = Attention.new
    @user = current_user.id
    @actual = true
  end

  # GET /attentions/1/edit
  def edit
    @user = @attention.user_id
    @actual = @attention.actual
  end

  # POST /attentions
  # POST /attentions.json
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

  # PATCH/PUT /attentions/1
  # PATCH/PUT /attentions/1.json
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

  # DELETE /attentions/1
  # DELETE /attentions/1.json
  def destroy
    @attention.destroy
    respond_to do |format|
      format.html { redirect_to attentions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attention
      @attention = Attention.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attention_params
      params.require(:attention).permit(:name, :user_id, :description, :src_url, :img_url, :attn_cat_id, :actual, :author_id)
    end
end