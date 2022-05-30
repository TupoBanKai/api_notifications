class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :type
      t.string :title
      t.string :content
      t.string :last_sent_at
      t.timestamps
    end
  end
end
