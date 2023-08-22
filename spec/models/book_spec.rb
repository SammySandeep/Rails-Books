require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(100) }
    it { should validate_presence_of(:author) }
    it { should validate_length_of(:author).is_at_least(3).is_at_most(100) }
    it { should validate_presence_of(:published_year) }
    it { should validate_numericality_of(:published_year).only_integer.is_greater_than_or_equal_to(0) }

    context "published year is in the future" do
      before { book.published_year = Date.today.year + 1 }

      it "is not valid" do
        expect(book).not_to be_valid
        expect(book.errors.messages[:published_year]).to include("can't be in the future")
      end
    end

    context "published year is current year" do
      before { book.published_year = Date.today.year }

      it "is valid" do
        expect(book).to be_valid
      end
    end
  end

  describe "callbacks" do
    context "after_save" do
      it "calls notify_endpoints" do
        expect(NotifyEndpointsJob).to receive(:perform_later).with(an_instance_of(Book))
        book.save!
      end
    end
  end
end
