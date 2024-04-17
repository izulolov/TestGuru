# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#=begin
users = User.create!([{first_name: 'Ikbol', last_name: 'Zulolov', email: 'izulolov@mail.ru', password: '123456'},
          {first_name: 'Artem',last_name: 'Lebedev', email: 'artem@mail.ru', password: '123456'},
          {first_name: 'Sergey',last_name: 'Larionov', email: 'sergey@mail.ru', password: '123456'},
          {first_name: 'Mikel',last_name: 'Pronin', email: 'mikel@mail.ru', password: '123456'},
            ])
categories = Category.create!([
          {title: 'Junior'},
          {title: 'Middle'},
          {title: 'Senior'}
          ])

tests = Test.create!([
          {title: 'Ruby', level: 1, category_id: categories[0].id, user_id: users[1].id},
          {title: 'Ruby', level: 2, category_id: categories[1].id, user_id: users[2].id},
          {title: 'Ruby', level: 3, category_id: categories[2].id, user_id: users[2].id},
          {title: 'HTML', level: 1, category_id: categories[0].id, user_id: users[2].id},
          {title: 'HTML', level: 2, category_id: categories[1].id, user_id: users[3].id},
          {title: 'CSS', level: 6, category_id: categories[0].id, user_id: users[1].id},
          {title: 'CSS', level: 2, category_id: categories[1].id, user_id: users[2].id},
          {title: 'SQL', level: 1, category_id: categories[0].id, user_id: users[3].id},
          {title: 'C#', level: 1, category_id: categories[0].id, user_id: users[2].id},
          {title: 'C#', level: 2, category_id: categories[1].id, user_id: users[2].id},
          {title: 'C#', level: 3, category_id: categories[2].id, user_id: users[1].id},
          {title: 'C++', level: 5, category_id: categories[0].id, user_id: users[0].id},
          {title: 'C++', level: 3, category_id: categories[2].id, user_id: users[1].id},
          {title: 'JS', level: 1, category_id: categories[0].id, user_id: users[1].id},
          {title: 'JS', level: 4, category_id: categories[1].id, user_id: users[2].id},
          {title: 'Java', level: 2, category_id: categories[1].id, user_id: users[2].id},
          {title: 'Java', level: 3, category_id: categories[2].id, user_id: users[1].id},
          {title: 'Python', level: 1, category_id: categories[0].id, user_id: users[2].id},
          {title: 'Python', level: 2, category_id: categories[1].id, user_id: users[2].id},
          {title: 'Go', level: 4, category_id: categories[1].id, user_id: users[2].id},
          {title: 'Go', level: 3, category_id: categories[2].id, user_id: users[0].id}
                    ])
                    
questions = Question.create!([
          {body: 'Как узнать длину строки в ruby?', test_id: tests[0].id},
          {body: 'Как удалить элемент из массива ruby?', test_id: tests[0].id},
          {body: 'Как преобразовать переменную из числа в строку?', test_id: tests[0].id},
          {body: 'Что делает оператор «%»?', test_id: tests[8].id},
          {body: 'Какие бывают массивы?', test_id: tests[8].id},
          {body: 'Что обозначает ключевое слово var?', test_id: tests[8].id}
          ])

answers = Answer.create!([
          {body: 'Длину строки можно узнать с помощью методов size и length', correct: true, question_id: questions[0].id},
          {body: 'С помощью методов select и chomp', correct: false, question_id: questions[0].id},
          {body: 'Длину строки можно узнать с помощью метода count', correct: false, question_id: questions[0].id},
          {body: 'Длину строки можно нельзя узнать в руби!', correct: false, question_id: questions[0].id},
          {body: 'Удаления элемента из массива выполняется с помощью метода delete', correct: true, question_id: questions[1].id},
          {body: 'Удаления элекмента выполняется методом remove', correct: false, question_id: questions[1].id},
          {body: 'Удаления элекмента выполняется методом udalit', correct: false, question_id: questions[1].id},
          {body: 'С помощью метода to_s', correct: true, question_id: questions[2].id},
          {body: 'С помощью метода to_c', correct: false, question_id: questions[2].id},
          {body: 'С помощью метода to_f', correct: false, question_id: questions[2].id},
          {body: 'Возвращает остаток от деления', correct: true, question_id: questions[3].id},
          {body: 'Возвращает процент от суммы', correct: false, question_id: questions[3].id},
          {body: 'Возвращает тригонометрическую функцию', correct: false, question_id: questions[3].id},
          {body: 'Сложные и простые', correct: false, question_id: questions[4].id},
          {body: 'Одномерные и многомерные', correct: true, question_id: questions[4].id},
          {body: 'Резиновые и статичные', correct: false, question_id: questions[4].id},
          {body: 'Устраивает войну между программами', correct: false, question_id: questions[5].id},
          {body: 'Такого слова нету в C#', correct: false, question_id: questions[5].id},
          {body: 'Обозначает что переменная имеет явный тип данных', correct: false, question_id: questions[5].id},
          {body: 'Обозначает что переменная без явного типа данных', correct: true, question_id: questions[5].id}
          ])

usertests = TestPassage.create!([
          {user_id: users[0].id, test_id: tests[0].id},
          {user_id: users[1].id, test_id: tests[8].id},
          {user_id: users[3].id, test_id: tests[0].id},
          {user_id: users[2].id, test_id: tests[0].id},
          {user_id: users[1].id, test_id: tests[8].id},
          {user_id: users[2].id, test_id: tests[0].id},
          {user_id: users[1].id, test_id: tests[8].id},
          {user_id: users[0].id, test_id: tests[0].id}])
#=end
