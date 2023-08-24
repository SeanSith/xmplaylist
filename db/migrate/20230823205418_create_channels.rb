class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :content_id
      t.jsonb :detail, null: false, default: '{}'

      t.timestamps
    end

    add_index :channels, [:content_id], unique: true
  end
end
