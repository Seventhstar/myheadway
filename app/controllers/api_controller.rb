class ApiController < ApplicationController
  respond_to :json
  def random_statement
    st = Statement.order("RANDOM()").first
    render json: [body: st.content, author: st.author_name]
  end
end
