FactoryGirl.define do
  factory :user do
    name "test_user"
  end

  factory :group do
    name "test_group"
    user
  end

  factory :theme do
    # name "test_theme"
    # hashtag "test_hashtag"
    sequence(:name) { |n| "test_theme#{n}" }
    sequence(:hashtag) { |h| "test_hashtag#{h}" }
    group
  end

  factory :group_stat do
    day DateTime.parse("01-01-2016")
    unique_visitors_count 10
    subscribed_count 5
    unsubscribed_count 2
    group
  end

  factory :group_post do
    text "lorem ipsum"
    likes_count 11
    date DateTime.parse("12-02-2015")
    group
    group_stat
    theme
  end

  factory :age_cluster do
    from_12_to_18_count 64
    from_18_to_21_count 32
    from_21_to_24_count 16
    from_24_to_27_count 8
    from_27_to_30_count 4
    from_30_to_35_count 2
    from_35_to_45_count 1
    from_45_to_100_count 0
    group_stat
  end
end
