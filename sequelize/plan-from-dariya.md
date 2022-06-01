1. Создаем заготовку проекта (package.json, eslint, gitignore) и устанавливаем необходимые зависимости:
npm i sequelize sequelize-cli pg pg-hstore

2. Добавляем в проект .sequelizerc и копируем в него содержимое из документации

3. Инициализируем проект

npx sequelize-cli init


3. создать модель

npx sequelize-cli model:generate --name User --attributes firstName:string,lastName:string,email:string

Когда создаем модель, называем ее в единственном числе, однако таблица будет названа во множественном
Также при создании таблицы в модель добавятся поля id, createdAt, updatedAt

Если мы хотим внести какие-то изменения, например обновить модель ВАЖНО обновить миграции (руками)


3. После того, как первая миграция создана, ее надо накатить
npx sequelize-cli db:migrate
https://github.com/wCotito/cheat-sheets-js
references: {
  model: 'Users' // во множественном числе
  key: 'id'
}

В моделях добавить информацию в associate
Пример:
в модель на которую ссылаемся

this.hasMany(Player, {
  foreignKey: 'clubId'
});

в модель, которой ссылаемся

this.belongsTo(Team, {
  foreignKey: 'clubId'
});

5. seeder

 npx sequelize-cli seed:generate --name user

 Далее заполняем массив данных и выполняем команду
 npx sequelize-cli db:seed:all

 или для отдельного сидера

 npx sequelize-cli db:seed --seed 20210810202032-post.js  


