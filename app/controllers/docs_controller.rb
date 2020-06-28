class DocsController < ApplicationController
  before_action :set_doc, only: [:show, :edit, :update, :destroy]

  def index
    @docs = Doc.order(:name)
    @cur_doc = params[:doc_id].nil? ? @docs.first : Doc.find(params[:doc_id])
  end

  def show
  end

  def new
    @doc = Doc.new
  end

  def edit
  end

  def create
    @doc = Doc.new(doc_params)

    respond_to do |format|
      if @doc.save
        format.html { redirect_to docs_url, notice: 'Doc was successfully created.' }
        format.json { render action: 'show', status: :created, location: @doc }
      else
        format.html { render action: 'new' }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @doc.update(doc_params)
        format.html { redirect_to docs_url, notice: 'Doc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doc.destroy
    respond_to do |format|
      format.html { redirect_to docs_url }
      format.json { head :no_content }
    end
  end

  private
    def set_doc
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:name, :doc_type_id, :description)
    end
end
