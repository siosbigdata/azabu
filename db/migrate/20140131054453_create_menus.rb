class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :group_id
      t.integer :parent_id
      t.string :name
      t.string :title
      t.integer :vieworder
      t.string :icon
      t.integer :menutype

      t.timestamps
    end
  end
end
