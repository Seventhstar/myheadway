class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]

  # GET /statements
  # GET /statements.json
  def index
#     @statements = Statement.all
    if params[:tagid] 
      @tag = Tag.find(params[:tagid])
      @statements = @tag.statements.paginate(:page => params[:page], :per_page => 5)
    elsif params[:authorid]
      @author = Author.find_by! id: params[:authorid]
      @statements = @author.statements.search(params[:search]).order('id').paginate(:page => params[:page], :per_page => 5)
    else
       @statements = Statement.search(params[:search]).order('id').paginate(:page => params[:page], :per_page => 5)
    end
    @tags = Tag.all.order(:name)
    @model_name = controller_name.classify
#     @statements = Statement.find(params[:id]).order('id').paginate(:page => params[:page], :per_page => 5)
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
  end

  # GET /statements/new
  def new
    @statement = Statement.new
     @tags = Tag.all.order(:name)
  end

  # GET /statements/1/edit
  def edit
    @statement = Statement.find(params[:id])
    @tags = Tag.all.order(:name)
  end

  # POST /statements
  # POST /statements.json
  def create
    @statement = Statement.new(statement_params)

    respond_to do |format|
      if @statement.save
        format.html { redirect_to statements_url, notice: 'Statement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @statement }
      else
        format.html { render action: 'new' }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statements/1
  # PATCH/PUT /statements/1.json
  def update
    respond_to do |format|
      if @statement.update(statement_params)
        format.html { redirect_to statements_url, notice: 'Statement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to statements_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = Statement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statement_params
      
      params.require(:statement).permit(:author_id, :source, :theme, :content, :author_name, :tag_tokens, :book_name)
      
    end
end
