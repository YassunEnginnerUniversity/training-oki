# == Schema Information
#
# Table name: seats
#
#  id          :integer          not null, primary key
#  seat_area   :string
#  seat_number :integer
#  ticket_id   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Seat, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
