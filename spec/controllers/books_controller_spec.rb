require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET index' do
    it 'populates an array of books' do
      book1 = FactoryBot.create(:book) 
      book2 = FactoryBot.create(:book) 

      get :index
      expect(assigns(:books)).to match_array([book1, book2])
    end

    it 'render index view' do
      get :index
      expect(response).to render_template :index
    end
  end
end