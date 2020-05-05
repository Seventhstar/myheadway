class AjaxController < ApplicationController

  def authors
    if params[:term]
      like= "%".concat(params[:term].concat("%"))
      authors = Author.where("name like ? ", like)
    else
      authors = Author.all
    end
    list = authors.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    render json: list
  end

  def books
    if params[:term]
      like= "%".concat(params[:term].concat("%"))
      books = Book.where("name like ? ", like)
    else
      books = Book.all
    end
    list = books.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    render json: list
  end

  def targets
    if params[:term]
      like= "%".concat(params[:term].concat("%"))
#      targets = Target.where("name like ?", like)
      targets = Target.where("name like ? and parent_id is NULL ", like)
    else
      targets = Target.all
    end
    list = targets.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    render json: list
  end

  def target_days
    if params[:target]
      find_query = {target_id: params[:target], day: params[:day], month: params[:month], year: params[:year]}
      target_day = TargetDay.where(find_query).first
      if target_day != nil
        target_day.state = params[:state]
      else
        find_query[:state] = params[:state]
        target_day = TargetDay.new(find_query)
      end
      target_day.save
      render nothing: true, status: 200, content_type: 'text/html'
    end

    # respond_to do |format|
    #   format.html { render :text => "Rescued HTML" }
    #   format.js { render :action => "errors" }
    # end
  end

  def add_option
    if params['model'] && params['model']!='undefined'
      obj = params['model'].classify.constantize.find_or_create_by(name: params['name'])
    end
    # respond_to do |format|
    #   format.json { render :json => @post }
    # end
    render json: obj.id
    # respond_to do |format|
    #   format.js { render :json obj }
    # end
  end

  def upd_param
    if params['model'] && params['model']!='undefined'

      obj = Object.const_get(params['model']).find(params['id'])
      params[:upd].each do |p|
        #p "p",p,obj[p[0]]
        new_value = p[1]
        new_value.gsub!(' ','') if p[0]=='sum'
        obj[p[0]] = new_value
      end
      obj.save
     end
     render :nothing => true
    end


end
