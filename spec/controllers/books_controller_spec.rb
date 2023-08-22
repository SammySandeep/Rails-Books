require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe "GET #index" do
    let!(:books) { create_list(:book, 5) }

    it "assigns all books and renders the index view" do
      get :index
      expect(assigns(:books)).to match_array(books)
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    it "assigns a new book and renders the new view" do
      get :new
      expect(assigns(:book)).to be_a_new(Book)
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:book_attributes) { attributes_for(:book) } 

      it "creates a new book and redirects to the books index" do
        expect {
          post :create, params: { book: book_attributes }
        }.to change(Book, :count).by(1)

        expect(response).to redirect_to books_path
        expect(flash[:notice]).to eq "Book was successfully created."
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { { title: "", author: "", published_year: "" } }

      it "does not save the book and re-renders the new view" do
        expect {
          post :create, params: { book: invalid_attributes }
        }.not_to change(Book, :count)

        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    let!(:book) { create(:book) }

    context "with valid attributes" do
      let(:updated_attributes) { { title: "Updated Title" } }

      it "updates the book and redirects to the books index" do
        put :update, params: { id: book.id, book: updated_attributes }
        book.reload

        expect(book.title).to eq "Updated Title"
        expect(response).to redirect_to books_path
        expect(flash[:notice]).to eq "Book was successfully updated."
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { { title: "" } }

      it "does not update the book and re-renders the edit view" do
        put :update, params: { id: book.id, book: invalid_attributes }
        book.reload

        expect(book.title).not_to be_empty
        expect(response).to render_template :edit
      end
    end
  end
end
