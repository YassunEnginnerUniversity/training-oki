# == Schema Information
#
# Table name: tickets
#
#  id             :integer          not null, primary key
#  used_time      :datetime
#  transfer_time  :datetime
#  ticket_type_id :integer          not null
#  entrance_id    :integer          not null
#  ticket_view_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Ticket, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
