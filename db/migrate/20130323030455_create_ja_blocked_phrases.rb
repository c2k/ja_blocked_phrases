class CreateJaBlockedPhrases < ActiveRecord::Migration
  def change
    create_table :ja_blocked_phrases do |t|
      t.text :phrase
      t.references :ja_blocked_root
      t.boolean :furigana, :default => false

      t.timestamps
    end
    add_index :ja_blocked_phrases, :ja_blocked_root_id
  end
end
