class ListPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end
