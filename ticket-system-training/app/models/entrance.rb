# == Schema Information
#
# Table name: entrances
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Entrance < ApplicationRecord
  has_many :tickets
end
