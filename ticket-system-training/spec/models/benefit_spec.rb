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
require 'rails_helper'

RSpec.describe Benefit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
