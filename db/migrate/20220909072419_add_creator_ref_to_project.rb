# frozen_string_literal: true

class AddCreatorRefToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :creator, references: :users, index: true, foreign_key: { to_table: :users }
  end
end
