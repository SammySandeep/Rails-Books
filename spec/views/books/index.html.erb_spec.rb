require 'rails_helper'

RSpec.describe "books/index.html.erb", type: :view do
  before do
    assign(:books, [
      Book.create!(title: "Title1", author: "Author1", published_year: 2021),
      Book.create!(title: "Title2", author: "Author2", published_year: 2022)
    ])
    render
  end

  it "displays the title" do
    expect(rendered).to match /Books List/
  end

  it "has a link to add a new book" do
    expect(rendered).to have_link('Add New Book', href: new_book_path)
  end

  it "displays a list of books" do
    expect(rendered).to match /Title1/
    expect(rendered).to match /Author1/
    expect(rendered).to match /2021/
    expect(rendered).to match /Title2/
    expect(rendered).to match /Author2/
    expect(rendered).to match /2022/
  end

  it "has a link to edit each book" do
    expect(rendered).to have_link('Edit', href: edit_book_path(Book.first))
    expect(rendered).to have_link('Edit', href: edit_book_path(Book.last))
  end
end
