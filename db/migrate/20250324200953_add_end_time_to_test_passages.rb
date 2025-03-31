class AddEndTimeToTestPassages < ActiveRecord::Migration[6.1]
  def change
    add_column :test_passages, :end_time, :datetime
  end
end
