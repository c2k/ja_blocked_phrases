class CreateJaBlockedRoots < ActiveRecord::Migration
  def change
    create_table :ja_blocked_roots do |t|
      t.string :root

      t.timestamps
    end
  end
end
