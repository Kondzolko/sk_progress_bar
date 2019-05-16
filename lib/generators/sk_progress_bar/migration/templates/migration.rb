# frozen_string_literal: true

# Migration responsible for creating a table with activities
class CreateSkProgressBar < (ActiveRecord.version.release() < Gem::Version.new('5.2.0') ? ActiveRecord::Migration : ActiveRecord::Migration[5.2])
  # Create table
  def self.up
    create_table :sk_progress_bar do |t|
      t.string :message
      t.string :sk_process_id
      t.integer :process_status

      t.timestamps
    end

    add_index :sk_progress_bar, [:message, :sk_process_id, :process_status]
  end
  # Drop table
  def self.down
    drop_table :sk_progress_bar
  end
end