class BadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def award_badges
    Badge.all.each do |badge|
      award_badge(badge) if check_badge_rule(badge)
    end
  end

  private

  attr_reader :user, :test, :test_passage

  def check_badge_rule(badge)
    # Проверяем, что тест пройден успешно
    return false unless test_passage.passed

    rule_method = "#{badge.rule}?".to_sym

    if respond_to?(rule_method, true)
      # Передаем бейдж в метод проверки правила, чтобы использовать его параметры
      send(rule_method, badge)
    else
      Rails.logger.warn("Неизвестный метод управления значком: #{rule_method}")
      false
    end
  end

  def award_badge(badge)
    user.badges << badge
  end

  def first_attempt?(badge)
    user.test_passages.where(test: test).count == 1
  end

  def passed_all_tests_of_some_level?(badge)
    # Используем значение уровня из бейджа
    level = badge.rule_value.to_i
    
    # Проверяю соответсвует уровен теста уровню бейджа
    return false unless test.level == level
    
    all_tests_by_level = Test.by_level(level)
    return false if all_tests_by_level.empty?
    
    passed_test_ids = user.test_passages.where(passed: true)
                          .where(test_id: all_tests_by_level)
                          .select(:test_id).distinct.pluck(:test_id)
    
    all_tests_by_level.count == passed_test_ids.count
  end

  def passed_all_tests_of_some_category?(badge)
    category_id = badge.rule_value.to_i
    
    # Сначала проверяем, соответствует ли текущий тест категории бейджа
    return false unless test.category_id == category_id
    
    # Получаем все тесты нужной категории напрямую, без предварительной загрузки категории
    all_tests_by_category = Test.where(category_id: category_id)
    return false if all_tests_by_category.empty?
    
    # Получаем уникальные ID тестов, которые пользователь прошел успешно
    passed_test_ids = user.test_passages.where(passed: true)
                          .where(test_id: all_tests_by_category)
                          .select(:test_id).distinct.pluck(:test_id)
    
    # Проверяем, что пользователь прошел все тесты этой категории
    all_tests_by_category.count == passed_test_ids.count
  end
  
end
