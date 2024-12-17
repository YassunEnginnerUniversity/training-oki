# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# ユーザデータ挿入
User.create!([
  { name: 'ユーザA', email: 'userA@example.com', password: 'passwordA' },
  { name: 'ユーザB', email: 'userB@example.com', password: 'passwordB' },
  { name: 'ユーザC', email: 'userC@example.com', password: 'passwordC' }
])

# 興行主
Organizer.create!([
  { name: '興行主A' },
  { name: '興行主B' },
  { name: '興行主C' }
])

# プレイガイド
PlayGuide.create!([
  { name: 'プレイガイドA' },
  { name: 'プレイガイドB' },
  { name: 'プレイガイドC' }
])

# 興行データ
Show.create!([
  { name: '興行A', start_datetime: '2024-08-01 10:00:00', end_datetime: '2024-08-01 18:00:00', details: '興行A詳細', organizer_id: 1},
  { name: '興行B', start_datetime: '2024-01-01 18:00:00', end_datetime: '2024-01-02 21:00:00', details: '興行B詳細', organizer_id: 1},
  { name: '興行C', start_datetime: '2024-09-01 09:00:00', end_datetime: '2024-09-01 17:00:00', details: '興行C詳細', organizer_id: 2},
  { name: '興行D', start_datetime: '2024-08-05 11:00:00', end_datetime: '2024-08-05 20:00:00', details: '興行D詳細', organizer_id: 2},
  { name: '興行E', start_datetime: '2024-08-10 12:00:00', end_datetime: '2024-08-10 19:00:00', details: '興行E詳細', organizer_id: 3},
  { name: '興行F', start_datetime: '2024-09-15 10:30:00', end_datetime: '2024-09-15 16:30:00', details: '興行F詳細', organizer_id: 3}
])

# 公演データ挿入
Event.create!([
  # 興行A
  { name: '公演A', details: '公演A1の詳細', date: '2024-08-05', venue: '会場A', open_time: '17:00', start_time: '18:00', end_time: '21:00', show_id: 1 },
  { name: '公演A2', details: '公演A2の詳細', date: '2024-08-10', venue: '会場B', open_time: '16:30', start_time: '17:30', end_time: '20:30', show_id: 1 },
  # 興行B
  { name: '公演B', details: '公演B1の詳細', date: '2024-01-01', venue: '会場D', open_time: '16:00', start_time: '17:00', end_time: '20:00', show_id: 2 },
  { name: '公演B2', details: '公演B2の詳細', date: '2024-01-02', venue: '会場E', open_time: '15:30', start_time: '16:30', end_time: '19:30', show_id: 2 },
  # 興行C
  { name: '公演C', details: '公演C1の詳細', date: '2024-08-15', venue: '会場G', open_time: '16:00', start_time: '17:00', end_time: '19:00', show_id: 3 },
  { name: '公演C2', details: '公演C2の詳細', date: '2024-08-25', venue: '会場H', open_time: '15:30', start_time: '16:30', end_time: '18:30', show_id: 3 },
  # 興行D
  { name: '公演D', details: '公演D1の詳細', date: '2024-09-05', venue: '会場I', open_time: '16:30', start_time: '17:30', end_time: '20:30', show_id: 4 },
  { name: '公演D2', details: '公演D2の詳細', date: '2024-09-10', venue: '会場J', open_time: '17:00', start_time: '18:00', end_time: '21:00', show_id: 4 },
  # 興行E
  { name: '公演E', details: '公演E1の詳細', date: '2024-09-15', venue: '会場K', open_time: '17:00', start_time: '18:00', end_time: '21:00', show_id: 5 },
  { name: '公演E2', details: '公演E2の詳細', date: '2024-09-20', venue: '会場L', open_time: '16:00', start_time: '17:00', end_time: '20:00', show_id: 5 },
  # 興行F
  { name: '公演F', details: '公演F1の詳細', date: '2024-01-05', venue: '会場M', open_time: '17:00', start_time: '18:00', end_time: '21:00', show_id: 6 },
  { name: '公演F2', details: '公演F2の詳細', date: '2024-01-06', venue: '会場N', open_time: '16:00', start_time: '17:00', end_time: '20:00', show_id: 6 }
])

# 券種データ挿入
TicketType.create!([
  { name: '券種A', price: 10000, event_id: 1 },
  { name: '券種B', price: 12000, event_id: 1 },
  { name: '券種A', price: 15000, event_id: 2 },
  { name: '券種B', price: 20000, event_id: 2 },
  { name: '券種A', price: 18000, event_id: 3 },
  { name: '券種B', price: 13000, event_id: 3 },
  { name: '券種A', price: 8000, event_id: 4 },
  { name: '券種B', price: 8500, event_id: 4 },
  { name: '券種D1', price: 9000, event_id: 7 },
  { name: '券種D2', price: 9500, event_id: 7 },
  { name: '券種E1', price: 11000, event_id: 9 },
  { name: '券種E2', price: 11500, event_id: 9 }
])

# 入場口データ挿入
Entrance.create!([
  { name: '入場口A' },
  { name: '入場口B' },
  { name: '入場口C' }
])

# チケットビュー
TicketView.create!([
  { user_id: 1, event_id: 5 },
  { user_id: 1, event_id: 1 },
  { user_id: 1, event_id: 2 },
  { user_id: 2, event_id: 1 },
  { user_id: 2, event_id: 3 },
  { user_id: 2, event_id: 4 },
  { user_id: 3, event_id: 3 },
  { user_id: 3, event_id: 5 },
  { user_id: 3, event_id: 6 }
])

# チケットデータ挿入
Ticket.create!([
  { used_time: nil, transfer_time: '2024-12-21 18:00:00', play_guide_id: 1, ticket_type_id: 1, entrance_id: 1, ticket_view_id: 4 }, # チケットビュー1
  { used_time: nil, transfer_time: nil, play_guide_id: 1, ticket_type_id: 1, entrance_id: 1, ticket_view_id: 2 }, # チケットビュー2
  { used_time: nil, transfer_time: nil, play_guide_id: 2, ticket_type_id: 3, entrance_id: 1, ticket_view_id: 3 }, # チケットビュー3
  { used_time: nil, transfer_time: '2024-11-21 18:00:00', play_guide_id: 1, ticket_type_id: 5, entrance_id: 2, ticket_view_id: 7 }, # チケットビュー4
  { used_time: nil, transfer_time: nil, play_guide_id: 2, ticket_type_id: 5, entrance_id: 2, ticket_view_id: 5 }, # チケットビュー5
  { used_time: nil, transfer_time: nil, play_guide_id: 3, ticket_type_id: 7, entrance_id: 2, ticket_view_id: 6 }, # チケットビュー6
  { used_time: nil, transfer_time: '2024-12-11 18:00:00', play_guide_id: 1, ticket_type_id: 9, entrance_id: 3, ticket_view_id: 1 }, # チケットビュー7
  { used_time: nil, transfer_time: nil, play_guide_id: 3, ticket_type_id: 9, entrance_id: 3, ticket_view_id: 8 }, # チケットビュー8
  { used_time: nil, transfer_time: nil, play_guide_id: 1, ticket_type_id: 11, entrance_id: 3, ticket_view_id: 9 } # チケットビュー9
])

# 座席データ挿入
Seat.create!([
  { seat_area: 'エリアA', seat_number: 101, ticket_id: 1 },
  { seat_area: 'エリアA', seat_number: 102, ticket_id: 2 },
  { seat_area: 'エリアB', seat_number: 201, ticket_id: 3 },
  { seat_area: 'エリアB', seat_number: 202, ticket_id: 4 },
  { seat_area: 'エリアC', seat_number: 301, ticket_id: 5 },
  { seat_area: 'エリアC', seat_number: 302, ticket_id: 6 },
  { seat_area: 'エリアD', seat_number: 401, ticket_id: 7 },
  { seat_area: 'エリアD', seat_number: 402, ticket_id: 8 },
  { seat_area: 'エリアE', seat_number: 501, ticket_id: 9 }
])

# 特典データ挿入
Benefit.create!([
  # チケットID 1 の特典
  { name: '特典A1', details: 'チケット1用の特典A', used_time: nil, ticket_id: 1 },
  { name: '特典B1', details: 'チケット1用の特典B', used_time: nil, ticket_id: 1 },

  # チケットID 2 の特典
  { name: '特典A2', details: 'チケット2用の特典A', used_time: nil, ticket_id: 2 },
  { name: '特典B2', details: 'チケット2用の特典B', used_time: nil, ticket_id: 2 },

  # チケットID 3 の特典
  { name: '特典A3', details: 'チケット3用の特典A', used_time: nil, ticket_id: 3 },
  { name: '特典B3', details: 'チケット3用の特典B', used_time: nil, ticket_id: 3 },

  # チケットID 4 の特典
  { name: '特典A4', details: 'チケット4用の特典A', used_time: nil, ticket_id: 4 },
  { name: '特典B4', details: 'チケット4用の特典B', used_time: nil, ticket_id: 4 },

  # チケットID 5 の特典
  { name: '特典A5', details: 'チケット5用の特典A', used_time: nil, ticket_id: 5 },
  { name: '特典B5', details: 'チケット5用の特典B', used_time: nil, ticket_id: 5 },

  # チケットID 7 の特典
  { name: '特典A7', details: 'チケット7用の特典A', used_time: nil, ticket_id: 7 },
  { name: '特典B7', details: 'チケット7用の特典B', used_time: nil, ticket_id: 7 },

  # チケットID 8 の特典
  { name: '特典A8', details: 'チケット8用の特典A', used_time: nil, ticket_id: 8 },
  { name: '特典B8', details: 'チケット8用の特典B', used_time: nil, ticket_id: 8 },

  # チケットID 9 の特典
  { name: '特典A9', details: 'チケット9用の特典A', used_time: nil, ticket_id: 9 },
  { name: '特典B9', details: 'チケット9用の特典B', used_time: nil, ticket_id: 9 }
])

# 移行データ挿入
Transfer.create!([
  { from_user_id: 1, to_user_id: 2, ticket_view_id: 1 },
  { from_user_id: 2, to_user_id: 3, ticket_view_id: 4 },
  { from_user_id: 3, to_user_id: 1, ticket_view_id: 7 }
])

