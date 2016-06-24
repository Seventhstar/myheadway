class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  # GET /statements
  # GET /statements.json
  def index    
    # @authors = Author.all.order(:name)
    # @tags    = Tag.all.order(:name)
    # @books = Book.order(:name)

    tags_ids = authors_ids = search_ids = books_ids = all_ids = Statement.all.ids
    params.delete_if{|k,v| v=='' || v=='0' || k=='_' }

    books_ids   = Book.find(params[:book_id]).statements.ids if !params[:book_id].nil?
    authors_ids = Author.find(params[:author_id]).statements.ids if !params[:author_id].nil?
    tags_ids    = Tag.find(params[:tag_id]).statements.ids if !params[:tag_id].nil?
    search_ids  = Statement.search(params[:search]).ids if !params[:search].nil?

    ids = authors_ids & tags_ids & search_ids & all_ids & books_ids
    @statements = Statement.where('id in (?)', ids).order(id: :desc).paginate(:page => params[:page], :per_page => 5)


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
    @books = Book.order(:name)
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
      params.require(:statement).permit(:author_id, :source, :theme, :content, :author_name,:author_id, :tag_tokens, :book_name, :isTip, :tag_ids=>[])
    end
end
