module MessagesHelper
    def can_edit_message?(message)
      message.created_at >= 5.minutes.ago
    end
end
  