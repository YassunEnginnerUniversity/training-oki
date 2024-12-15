# == Schema Information
#
# Table name: ticket_views
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  event_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe TicketView, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
