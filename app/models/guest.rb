class Guest < ApplicationRecord
    has_many :reservations, dependent: :destroy

    validates :guest_id, presence: true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :phone, presence: true
end
