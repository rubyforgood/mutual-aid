FactoryBot.define do
  factory :shift do
    person { nil }
    team { nil }
    started_at { "2020-05-18 14:25:55" }
    ended_at { "2020-05-18 14:25:55" }
    notes { "MyText" }
  end
end
