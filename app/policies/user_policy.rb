class UserPolicy < ApplicationPolicy
  def lists?
    user.present? && user == record
  end
  def following?
    lists?
  end
  def followers?
    lists?
  end
end
