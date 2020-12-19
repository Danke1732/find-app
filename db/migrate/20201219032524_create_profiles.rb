class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :hobby
      t.string :favorite_word
      t.text :introduction
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
