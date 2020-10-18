class AuthorsController < ApplicationController
  def index
    puts "@authors #{@authors}"
    @authors = Author.order(:name)
  end
end
