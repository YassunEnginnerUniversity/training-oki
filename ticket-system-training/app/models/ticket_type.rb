# == Schema Information
#
# Table name: ticket_types
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float
#  event_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TicketType < ApplicationRecord
  belongs_to :event
end
