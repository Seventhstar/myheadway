class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]

  def index
    @notices = Notice.all
  end

  def new
    @notice = Notice.new
  end

  def edit
  end

  def create
    @notice = Notice.new(notice_params)

    respond_to do |format|
      if @notice.save
        format.html { redirect_to notices_url, notice: 'Notice was successfully created.' }
        format.json { render action: 'show', status: :created, location: @notice }
      else
        format.html { render action: 'new' }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @notice.update(notice_params)
        format.html { redirect_to notices_url, notice: 'Notice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notice.destroy
    respond_to do |format|
      format.html { redirect_to notices_url }
      format.json { head :no_content }
    end
  end

  private
    def set_notice
      @notice = Notice.find(params[:id])
    end

    def notice_params
      params.require(:notice).permit(:name, :user_id)
    end
end
