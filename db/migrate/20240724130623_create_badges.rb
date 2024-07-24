class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.string :rule, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
