FactoryBot.define do
  factory :comment do
    user { nil }
    item { nil }
    content { "MyText" }
    deleted_at { "" }
  end
end
