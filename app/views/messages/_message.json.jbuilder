json.extract! message, :id, :content, :subject_id, :created_at, :updated_at
json.url message_url(message, format: :json)
