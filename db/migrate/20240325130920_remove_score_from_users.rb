class RemoveScoreFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :score, :integer
  end
end
