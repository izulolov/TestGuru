class AddDeadlineTimeToTestPassages < ActiveRecord::Migration[6.1]
  def change
    add_column :test_passages, :deadline_time, :datetime
    add_index :test_passages, :deadline_time
  end
end
