json.extract! booking, :id, :start, :end, :room_id, :library_member_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)