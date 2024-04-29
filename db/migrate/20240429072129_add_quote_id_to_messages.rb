class AddQuoteIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :quote_id, :integer
    add_index :messages, :quote_id
  end
end
