# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    admin? && (moderator? || admin?)
  end

  def show?
    admin? && (moderator? || admin?)
  end
end
