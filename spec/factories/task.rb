FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'Rspecの準備' }
    user
  end
end
