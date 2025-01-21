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
    case badge.rule
    when 'first_attempt'
      first_attempt?
    when 'all_tests_of_some_level'
      passed_all_tests_of_some_level?(test.level)
    when 'all_tests_backend'
      passed_all_backend_tests?
    else
      false
    end
  end

  def award_badge(badge)
    user.badges << badge #unless user.badges.include?(badge)
  end

  def first_attempt?
    user.test_passages.where(test: test).count == 1
  end

  def passed_all_tests_of_some_level?(level)
    tests_by_level = Test.by_level(level)
    passed_tests_count = user.test_passages.where(test: tests_by_level, passed: true).count
    tests_by_level.count == passed_tests_count
  end

  #def passed_all_backend_tests?
  #  backend_category = Category.find_by(title: 'Backend')
  #  user.tests.where(category: backend_category).count { |t| t.passed } == Test.where(category: backend_category).count
  #end
end
