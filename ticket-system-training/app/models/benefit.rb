# == Schema Information
#
# Table name: benefits
#
#  id         :integer          not null, primary key
#  name       :string
#  details    :text
#  used_time  :datetime
#  ticket_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Benefit < ApplicationRecord
  belongs_to :ticket
end
