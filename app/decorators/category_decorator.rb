class CategoryDecorator < Draper::Decorator
  delegate_all

  decorates_association :loans
end
