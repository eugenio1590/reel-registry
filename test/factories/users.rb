FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "ValidPassword!" }

    trait :invalid_email do
      email { "invalid_email" }
    end

    trait :short_password do
      password { "short" }
    end

    trait :no_lowercase_password do
      password { "PASSWORD1!" }
    end

    trait :no_uppercase_password do
      password { "password1!" }
    end

    trait :no_special_char_password do
      password { "Password10" }
    end
  end
end