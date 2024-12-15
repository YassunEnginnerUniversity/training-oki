class Ticket < ApplicationRecord
  belongs_to :ticket_type
  belongs_to :entrance
  belongs_to :ticket_view
end
