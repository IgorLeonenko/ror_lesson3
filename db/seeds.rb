# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: 'Igor', email: 'igrleon@gmail.com', password_digest: '123456')
User.create(name: 'Ivan', email: 'ivan@email.ww', password_digest: '654321')

body = "Вже давно відомо, що читабельний зміст буде заважати зосередитись людині, яка оцінює композицію сторінки. Сенс використання Lorem Ipsum полягає в тому, що цей текст має більш-менш нормальне розподілення літер на відміну від, наприклад, Це робить текст схожим на оповідний. Багато програм верстування та веб-дизайну використовують Lorem Ipsum як зразок і пошук за терміном відкриє багато веб-сайтів, які знаходяться ще в зародковому стані. Різні версії Lorem Ipsum з'явились за минулі роки, деякі випадково, деякі було створено зумисно (зокрема, жартівливі)."
body1 = "Існує багато варіацій уривків з Lorem Ipsum, але більшість з них зазнала певних змін на кшталт жартівливих вставок або змішування слів, які навіть не виглядають правдоподібно. Якщо ви збираєтесь використовувати Lorem Ipsum, ви маєте упевнитись в тому, що всередині тексту не приховано нічого, що могло б викликати у читача конфуз. Більшість відомих генераторів Lorem Ipsum в Мережі генерують текст шляхом повторення наперед заданих послідовностей Lorem Ipsum. Принципова відмінність цього генератора робить його першим справжнім генератором Lorem Ipsum. Він використовує словник з більш як 200 слів латини та цілий набір моделей речень - це дозволяє генерувати Lorem Ipsum, який виглядає осмислено. Таким чином, згенерований Lorem Ipsum не міститиме повторів, жартів, нехарактерних для латини слів і т.ін."
body2 = "Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer magna metus, faucibus non enim at, sodales posuere mauris. Quisque eget ultrices lectus. Duis hendrerit tincidunt neque, at scelerisque ante posuere vel. Mauris tempus odio in arcu scelerisque luctus. Quisque massa ligula, maximus in enim eu, scelerisque dignissim libero. Pellentesque maximus dolor eu eros pellentesque tempor. Vestibulum nec nisi scelerisque, aliquam nulla sit amet, malesuada nulla. Maecenas id laoreet quam. Aliquam felis sapien, pretium in nisi vitae, porta sodales erat. Donec sagittis, urna sed laoreet vulputate, erat odio tempor risus, sed feugiat est dui eget justo. Integer lacus enim, hendrerit et neque quis, maximus ultrices mi. Ut sed dui vel velit elementum interdum. Ut tincidunt venenatis mi in finibus. Integer nec elit mollis, aliquet ante nec, dapibus magna."

Post.create(user_id: 1, title: 'Test1', body: body)
Post.create(user_id: 1, title: 'Test2', body: body1)
Post.create(user_id: 1, title: 'Test3', body: body2)
Post.create(user_id: 1, title: 'Test4', body: body2)
Post.create(user_id: 1, title: 'Test5', body: body1)
Post.create(user_id: 1, title: 'Test6', body: body)
Post.create(user_id: 1, title: 'Test7', body: body2)
Post.create(user_id: 1, title: 'Test8', body: body1)
Post.create(user_id: 1, title: 'Test9', body: body1)
Post.create(user_id: 2, title: 'Test10', body: body)
Post.create(user_id: 2, title: 'Test11', body: body1)
Post.create(user_id: 2, title: 'Test12', body: body2)
Post.create(user_id: 2, title: 'Test13', body: body2)
Post.create(user_id: 2, title: 'Test14', body: body1)
Post.create(user_id: 2, title: 'Test15', body: body)
Post.create(user_id: 2, title: 'Test16', body: body2)
Post.create(user_id: 2, title: 'Test17', body: body1)
Post.create(user_id: 2, title: 'Test18', body: body1)