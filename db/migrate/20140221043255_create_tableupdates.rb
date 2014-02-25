class CreateTableupdates < ActiveRecord::Migration
  def change
    create_table :tableupdates do |t|
      t.integer :graph_id
      t.string :name
      t.integer :term
      t.date :cal_at
      t.integer :analysis_type

      t.timestamps
    end
  end
end
