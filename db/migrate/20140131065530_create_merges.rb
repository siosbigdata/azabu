class CreateMerges < ActiveRecord::Migration
  def change
    create_table :merges do |t|
      t.string :name
      t.string :title
      t.integer :term

      t.timestamps
    end
  end
end
