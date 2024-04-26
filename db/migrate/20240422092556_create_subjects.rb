class CreateSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :subjects do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
