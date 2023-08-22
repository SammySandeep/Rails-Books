class Book < ApplicationRecord
    after_save :notify_endpoints

    validates :title, presence: true, length: { minimum: 3, maximum: 100 }
    validates :author, presence: true, length: { minimum: 3, maximum: 100 }
    validates :published_year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validate :published_year_not_in_future

    private

    def published_year_not_in_future
        if published_year.present? && published_year > Date.today.year
          errors.add(:published_year, "can't be in the future")
        end
    end

    def notify_endpoints
        NotifyEndpointsJob.perform_later(self)    
    end
end