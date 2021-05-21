class Borrow < ApplicationRecord
    belongs_to :book
    belongs_to :user

    STATUSES = %w(approved denied pending)

    scope :pending, -> { where(status: :pending) }
    scope :approved, -> { where(status: :approved) }
    scope :denied, -> { where(status: :denied) }

    validates :status, inclusion: { in: Borrow::STATUSES }
end
