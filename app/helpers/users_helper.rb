# frozen_string_literal: true

module UsersHelper
  def select_user_type
    User.user_types.map { |key, _value| [key.capitalize, key] }
  end
end
