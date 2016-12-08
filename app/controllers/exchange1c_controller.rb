class Exchange1cController < ApplicationController

	skip_before_action :verify_authenticity_token

  def index
    @items = model.order(:id)
    render json: @items

  end

  def upload
  	p "model",model, model == Task
  	j_data = params[:_json]

  	if model == Task
  		j_data.each do |d|
  			t = model.find_by_guid_1c( d["guid"])
  			if t.nil?
  				t = Task.new
  			  t.name = d["name"]
  			  t.guid_1c = d["guid"]
  			  t.start_date =  Date.parse( d["dt"]) if !d["dt"].nil?
  			  t.upd_1c = true
  			  t.task_cat_id = TaskCat.find_by_code1c(d["cat"]).id
  			  t.save
  			end
  		end

  	else
	  	 j_data.each do |d|
	  	 	  tc = model.find_by_code1c( d["id"])
	  	 	  if tc.nil?
	  	 	  	tc = model.new
	  	 	  	tc.code1c = d["id"]
	  	 	  	tc.name = d["name"]
	  	 	  	tc.save
	  	 	  end
	  	 end
	  end

  	head :no_content
  end


  private
  	def model
      page = params[:model]
      page ||= "task_cats"
      page.classify.constantize
    end

end
