class DropAhoyTables < ActiveRecord::Migration[8.0]
  def change
    drop_table :ahoy_events, if_exists: true do |t|
    end

    drop_table :ahoy_visits, if_exists: true do |t|
    end
  end
end
