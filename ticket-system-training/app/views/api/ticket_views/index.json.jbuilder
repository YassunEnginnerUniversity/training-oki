json.array! @ticket_views do |ticket_view|
  json.id ticket_view.id
  json.user_id ticket_view.user_id
  json.event_id ticket_view.event_id

  json.event do
    json.id ticket_view.event.id
    json.name ticket_view.event.name
    json.details ticket_view.event.details
    json.date ticket_view.event.date
    json.venue ticket_view.event.venue
    json.open_time ticket_view.event.open_time
    json.start_time ticket_view.event.start_time
    json.end_time ticket_view.event.end_time

    json.show do
      json.id ticket_view.event.show.id
      json.name ticket_view.event.show.name
    end
  end
  json.tickets ticket_view.tickets do |ticket|
    json.id ticket.id
    json.used_time ticket.used_time
    json.transfer_time ticket.transfer_time
  end
end