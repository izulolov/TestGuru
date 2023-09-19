# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!([{name: 'Ikbol', score: 0},
          {name: 'Artem', score: 0},
          {name: 'Dmitry', score: 0},
          {name: 'Aleksey', score: 0},
          {name: 'Dmitry', score: 0},
          {name: 'Anton', score: 0},
          {name: 'Petr', score: 0},
          {name: 'Ivan', score: 0},
          {name: 'Sergey', score: 0},
          {name: 'Maksim', score: 0},
          {name: 'Anastasia', score: 0},
          {name: 'Elena', score: 0},
          {name: 'Svetlana', score: 0},
          {name: 'Marina', score: 0}
            ])
categories = Category.create!([
          {title: 'Junior'},
          {title: 'Middle'},
          {title: 'Senior'}
          ])

tests = Test.create!([
          {title: 'Ruby', level: 1, category_id: categories[0].id},
          {title: 'Ruby', level: 2, category_id: categories[1].id},
          {title: 'Ruby', level: 3, category_id: categories[2].id},
          {title: 'HTML', level: 1, category_id: categories[0].id},
          {title: 'HTML', level: 2, category_id: categories[1].id},
          {title: 'CSS', level: 1, category_id: categories[0].id},
          {title: 'CSS', level: 2, category_id: categories[1].id},
          {title: 'SQL', level: 1, category_id: categories[0].id},
          {title: 'C#', level: 1, category_id: categories[0].id},
          {title: 'C#', level: 2, category_id: categories[1].id},
          {title: 'C#', level: 3, category_id: categories[2].id},
          {title: 'C++', level: 1, category_id: categories[0].id},
          {title: 'C++', level: 3, category_id: categories[2].id},
          {title: 'JS', level: 1, category_id: categories[0].id},
          {title: 'JS', level: 2, category_id: categories[1].id},
          {title: 'Java', level: 2, category_id: categories[1].id},
          {title: 'Java', level: 3, category_id: categories[2].id},
          {title: 'Python', level: 1, category_id: categories[0].id},
          {title: 'Python', level: 2, category_id: categories[1].id},
          {title: 'Go', level: 2, category_id: categories[1].id},
          {title: 'Go', level: 3, category_id: categories[2].id}
                    ])
                    
questions = Question.create!([
          {body: 'Как узнать длину строки в ruby?', test_id: tests[0].id},
          {body: 'Как удалить элемент из массива ruby?', test_id: tests[0].id},
          {body: 'Как преобразовать переменную из числа в строку?', test_id: tests[0].id}
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
          {body: 'С помощью метода to_f', correct: false, question_id: questions[2].id}
          ])

usertests = UserTest.create!([
          {user_id: users[0].id, test_id: tests[0].id},
          {user_id: users[1].id, test_id: tests[0].id},
          {user_id: users[3].id, test_id: tests[0].id},
          {user_id: users[7].id, test_id: tests[0].id},
          {user_id: users[11].id, test_id: tests[0].id},
          {user_id: users[12].id, test_id: tests[0].id},
          {user_id: users[0].id, test_id: tests[0].id},
          {user_id: users[0].id, test_id: tests[0].id},
          {user_id: users[1].id, test_id: tests[0].id}])
