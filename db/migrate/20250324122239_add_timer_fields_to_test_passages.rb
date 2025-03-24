class AddTimerFieldsToTestPassages < ActiveRecord::Migration[6.1]
  def change
    add_column :test_passages, :started_at, :datetime
    add_column :test_passages, :expires_at, :datetime
  end
end
