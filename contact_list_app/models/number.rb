class Number < ActiveRecord::Base
  belongs_to :contact
  validates :phone_number,
    presence: true,
    length: {
      minimum: 7
    }
end