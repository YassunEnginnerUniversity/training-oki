# == Schema Information
#
# Table name: shows
#
#  id             :integer          not null, primary key
#  name           :string
#  start_datetime :datetime
#  end_datetime   :datetime
#  details        :text
#  organizer_id   :integer          not null
#  play_guide_id  :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Show, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
