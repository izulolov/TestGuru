class BadgeService

  def initialize(user, test)
    @user = user
    @test = test
  end

  def award_badges
    Badge.all.each do |badge|
      award_badge(badge) if check_badge_rule(badge)
    end
  end

  private

  attr_reader :user, :test

  def check_badge_rule(badge)
    rule_method = "#{badge.rule}?".to_sym

    if respond_to?(rule_method, true)
      send(rule_method)
    else
      Rails.logger.warn("Неизвестный метод управления значком: #{rule_method}")
      false
    end
  end

  def award_badge(badge)
    user.badges << badge
  end

  def first_attempt?
    user.test_passages.where(test: test).count == 1
  end

  def passed_all_tests_of_some_level?
    all_tests_by_level = Test.by_level(test.level)
    passed_tests_count = user.test_passages.where(test: all_tests_by_level, passed: true).count
    all_tests_by_level.count == passed_tests_count
  end

  def passed_all_tests_of_some_category?
    all_tests_by_category = Test.by_category(test.category)
    all_passed_tests_by_category = user.test_passages.where(test: all_tests_by_category, passed: true)
                                                      .distinct(:test_id)
    all_tests_by_category.count == all_passed_tests_by_category.count
  end
end
