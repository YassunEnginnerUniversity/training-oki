# == Schema Information
#
# Table name: organizers
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organizer < ApplicationRecord
  has_many :shows
end
