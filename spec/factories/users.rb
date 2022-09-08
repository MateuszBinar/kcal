FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    created_at { DateTime.now - 1.day }
    password { 'Haselko2000!' }
    password_confirmation { 'Haselko2000!' }
  end
end
