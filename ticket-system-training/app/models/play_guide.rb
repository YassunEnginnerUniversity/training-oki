# == Schema Information
#
# Table name: play_guides
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PlayGuide < ApplicationRecord
  has_many :shows
end
