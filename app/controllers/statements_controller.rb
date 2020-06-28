class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  def index    
    # @authors = Author.all.order(:name)
    # @tags    = Tag.all.order(:name)
    # @books = Book.order(:name)

    tags_ids = authors_ids = search_ids = books_ids = all_ids = Statement.all.ids
    params.delete_if{|k,v| v == '' || v == '0' || k == '_' }

    tags_ids    = Tag.find(params[:tag_id]).statements.ids if !params[:tag_id].nil?
    books_ids   = Book.find(params[:book_id]).statements.ids if !params[:book_id].nil?
    authors_ids = Author.find(params[:author_id]).statements.ids if !params[:author_id].nil?

    s = "%#{params[:search]}%"
    search_ids  = Statement.where('lower(content) like ?', s.downcase).ids if !params[:search].nil?

    ids = authors_ids & tags_ids & search_ids & all_ids & books_ids
    @statements = Statement.where('id in (?)', ids).order(id: :desc).paginate(page: params[:page], per_page: 5)
  end

  def new
    @statement = Statement.new
     @tags = Tag.all.order(:name)
  end

  def edit
    @statement = Statement.find(params[:id])
    @tags = Tag.all.order(:name)
    @books = Book.order(:name)
  end

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

  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to statements_url }
      format.json { head :no_content }
    end
  end

  private
    def set_statement
      @statement = Statement.find(params[:id])
    end

    def statement_params
      params.require(:statement).permit(:author_id, :source, :theme, :content, :author_name, 
                                        :image_url, :tag_tokens, :book_name, :isTip, :tag_ids => [])
    end
end
