# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  def new?
    user.qa?
  end

  def update?
    record.bug_owner?(user.id)
  end

  def edit?
    record.bug_owner?(user.id)
  end

  def assign_bug?
    user.dev?
  end
end
