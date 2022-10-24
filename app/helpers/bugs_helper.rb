# frozen_string_literal: true

module BugsHelper
  def bug_types
    Bug.bug_types.map { |key, _value| [key.capitalize, key] }
  end
end
