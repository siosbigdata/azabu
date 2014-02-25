class CreateMergegraphs < ActiveRecord::Migration
  def change
    create_table :mergegraphs do |t|
      t.integer :merge_id
      t.integer :graph_id
      t.integer :side
      t.string :y
      t.integer :vieworder

      t.timestamps
    end
  end
end
