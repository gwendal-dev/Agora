class AddQuotedMessageIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :quoted_message_id, :integer
  end
end
