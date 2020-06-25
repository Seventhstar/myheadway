class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :def_params, only: [:new, :edit, :update]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    @columns = %w"has_picture name author_id"
    fields  = %w"".concat(@columns)
    
    @json_data = []
    @filterItems = %w'author'

    @books.order(:name).each do |book| 
      h = {id: book.id, editable: true}
      
      fields.each do |col|
        c = col.include?(":") ? col.split(':')[0] : col.downcase
        h['has_picture'] = book.img_url.present?
        h[c] = book[c]
        if c.end_with?("_id")
          n = c[0..-4]
          h[n] = book.try(n).try("name")
        end
      end
      @json_data.push(h)
    end

  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_url, notice: 'Book was successfully created.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_url, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    def def_params
      @authors = Author.order(:name)
    end

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name, :author_id, :author_name, :img_url, :annotation)
    end
end
