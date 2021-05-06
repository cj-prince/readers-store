class Book < ApplicationRecord
    
    belongs_to :category
    validates :title, presence: true, length: { minimum: 3, maximum: 50 }
    validates :description, presence: true, length: { minimum: 10, maximum: 10000 }
    validates :author, presence: true

    has_attached_file :book_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/
end
