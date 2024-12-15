# == Schema Information
#
# Table name: transfers
#
#  id             :integer          not null, primary key
#  from_user_id   :integer
#  to_user_id     :integer
#  ticket_view_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Transfer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
