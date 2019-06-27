FactoryBot.define do
  factory :appointment do
    start_time { "" }
    end_time { "" }
    mentee { "" }
    mentor { "" }
    timezone { "" }
    location { "MyString" }
  end
end
