# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string
#  details    :text
#  date       :date
#  venue      :string
#  open_time  :time
#  start_time :time
#  end_time   :time
#  notes      :text
#  show_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Event < ApplicationRecord
  belongs_to :show

  has_many :ticket_types
end
