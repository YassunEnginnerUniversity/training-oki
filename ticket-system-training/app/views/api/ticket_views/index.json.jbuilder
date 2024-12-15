json.array! @ticket_views do |ticket_view|
  json.extract! ticket_view, :id, :user_id, :event_id
end