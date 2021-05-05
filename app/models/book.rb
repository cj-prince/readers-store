class Book < ApplicationRecord
    belongs_to :user
    belongs_to :category
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 10, maximum: 10000 }
    validates :author, presence: true
end
