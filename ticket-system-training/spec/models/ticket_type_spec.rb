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
require 'rails_helper'

RSpec.describe TicketType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
