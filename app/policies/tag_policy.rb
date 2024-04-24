# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  def index?
    admin? && !moderator?
  end

  def show?
    admin? && !moderator?
  end

  class Scope < Scope
    def resolve
      if user.present? && user.admin?
        scope.all
      else
        scope.where(status: 'active')
      end
    end
  end
end
