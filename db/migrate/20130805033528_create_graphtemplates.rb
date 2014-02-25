class CreateGraphtemplates < ActiveRecord::Migration
  def change
    create_table :graphtemplates do |t|
      t.string :linecolor
      t.string :bgfrom
      t.string :bgto
      t.string :textcolor
      t.string :name
      t.string :linecolor_pre
      t.string :linecolor_last

      t.timestamps
    end
  end
end
