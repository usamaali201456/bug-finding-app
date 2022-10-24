# frozen_string_literal: true

class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title, null: false
      t.datetime :deadline
      t.integer :bug_type, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
      t.belongs_to :user, foreign_key: true
      t.belongs_to :project, foreign_key: true
    end
  end
end
