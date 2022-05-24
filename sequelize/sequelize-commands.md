

Команды:

  `sequelize db:migrate`                        Run pending migrations // накатывает все миграции

  `sequelize db:migrate:schema:timestamps:add`  Update migration table to have timestamps

  `sequelize db:migrate:status`                 List the status of all migrations

  `sequelize db:migrate:undo`                   Reverts a migration  // откатывает одну последнюю миграцию

  `sequelize db:migrate:undo:all`               Revert all migrations ran // откатывает все миграции

  `sequelize db:seed  имя-файла сида`           Run specified seeder  // записывает данные в таблицу с определенного файла сида.

  `sequelize db:seed:undo  имя-файла сида`      Deletes data from the database  // удаляет из таблицы  с определенного файла сида.

  `sequelize db:seed:all`                       Run every seeder // записывает данные в таблицу из всех сидов

  `sequelize db:seed:undo:all`                  Deletes data from the database // удаляет данные из таблицы для всех сидов

  `sequelize db:create`                         Create database specified by configuration // создает базы данных которые прописанны в database.json

  `sequelize db:drop`                           Drop database specified by configuration // удаляет базы данных

  `sequelize init`                              Initializes project // инициализирует проект, если создан файл .sequelizerc
  то подтянет из него структуру папок базы данных.
  Шаблон структуры:

 <sup>const path = require('path');
  module.exports = {
 'config': path.resolve('config', 'config.json'),
 'models-path': path.resolve('db', 'models'),
 'seeders-path': path.resolve('db', 'seeders'),
 'migrations-path': path.resolve('db', 'migrations')
 };</sup>

  `sequelize init:config`                       Initializes configuration

  `sequelize init:migrations`                   Initializes migrations

  `sequelize init:models`                       Initializes models

  `sequelize init:seeders`                      Initializes seeders

  `sequelize migration:generate --name имяФайла` Generates a new migration file // создает новй пустой файл миграции.
  В него вы прописываете то что нужно добавить в таблицу отдельно, например новый столбец. Не забудьте в дальнейшем прописать ассоциации в моделях.

  `sequelize migration:create`                  Generates a new migration file

  `sequelize model:generate --name User --attributes user_name:string,age:integer`  - создание модели и соответствующей миграции.

  Где User пример имени модели(указывается в единственном числе), user_name пример атрибута(столбца в таблице):string типданных sequelize(см. файл DataType). атрибуты перечисляются через запятую. Ptimal key id, creatAt, updateAt создадутся
  автоматически.

  `sequelize model:create`                      Generates a model and its migration

  `sequelize seed:generate --name имя-файла`    Generates a new seed file // создание файла сида

  `sequelize seed:create `                      Generates a new seed file

Опции:
`--version` Показать номер версии                                                                                                                       `--help`  Показать помощь                                                                                                                      






