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
class Show < ApplicationRecord
  belongs_to :organizer
  belongs_to :play_guide

  has_many :events
end
