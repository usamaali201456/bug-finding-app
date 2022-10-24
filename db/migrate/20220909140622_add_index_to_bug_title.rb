# frozen_string_literal: true

class AddIndexToBugTitle < ActiveRecord::Migration[5.2]
  def change
    add_index :bugs, %i[title project_id], unique: true
  end
end
