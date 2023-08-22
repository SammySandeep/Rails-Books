require 'rails_helper'

RSpec.describe "Routing to books", type: :routing do
  it "routes / to books#index" do
    expect(get: "/").to route_to(controller: "books", action: "index")
  end

  it "routes /books to books#index" do
    expect(get: "/books").to route_to(controller: "books", action: "index")
  end

  it "routes /books/new to books#new" do
    expect(get: "/books/new").to route_to(controller: "books", action: "new")
  end

  it "routes /books/1/edit to books#edit" do
    expect(get: "/books/1/edit").to route_to(controller: "books", action: "edit", id: "1")
  end

end
