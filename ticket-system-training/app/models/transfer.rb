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
class Transfer < ApplicationRecord
  belongs_to :ticket_view
end
