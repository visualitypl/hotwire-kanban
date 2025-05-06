class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.references :board_column
      t.timestamps
    end
  end
end
