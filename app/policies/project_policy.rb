# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.dev?
        user.projects
      else
        scope.all
      end
    end
  end

  def new?
    user.manager?
  end

  def update?
    record.project_owner?(user.id)
  end

  def edit?
    record.project_owner?(user.id)
  end

  def destroy?
    record.project_owner?(user.id)
  end
end
