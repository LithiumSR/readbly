FactoryBot.define do
  factory :user do
    email                 "leosar@gmail.com"
    password              "password1234"
    password_confirmation "password1234"

    factory :admin do
      after(:create) {|user|
        user.add_role(:admin)
        user.remove_role(:user)}
    end

    factory :operator do
      after(:create) {|user|
        user.add_role(:operator)
        user.remove_role(:user)}
    end
  end

  factory :book do
    title "Harry Potter"
    overview "Example overview"
    isbn "1234567891"
    released_at "2000"
    publisher "Mondadori"
    author "JK"
  end
end