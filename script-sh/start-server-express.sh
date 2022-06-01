#!/bin/bash

# * При запуске данного скрипта будет создан сервер на expres,
# * база данных к нему на postgres.

# ! Перед тем как запустить скрипт поменяйте в нем данные подключения к БД!!
# ! И её название!!



# Для того что бы все сработало:
# 1) Сохраняете себе этот файл и кидаете его в корень нового проекта.
# 2) chmod +x start-server-express.sh  // файл по умолчанию не исполняемый, перед запуском выполнить эту команду в консоли где расположен файл,
# для его инициализации.
# P.S. В дальнейшем файл не нужно каждый раз инициализировать, достаточно просто кинуть в корень проекта и запустить.
# 3) Профит! Теперь файл можно запускить в корне любого проекта введя ./start-server-express.sh в консоли.

npm i  sequelize pg pg-hstore sequelize-cli
npm i  dotenv
npm i  express
npm i  hbs
npm i  morgan
npm i  nodemon

npm audit fix

# * Создает файл .sequelizerc c настройками инициализации базы данных.
echo  "const path = require('path')
require('dotenv').config()

module.exports = {
  'config': path.resolve('config', 'config.json'),
  'models-path': path.resolve('db', 'models'),
  'seeders-path': path.resolve('db', 'seeders'),
  'migrations-path': path.resolve('db', 'migrations')
}" > .sequelizerc

npx sequelize init # инициализация sequelize.

# * Создает файл .env с данными порта подключения к серверу и данными для созднания и подключения к БД
echo 'PORT=3000
DB_URL=postgres://username:password@localhost:5432/dbName' > .env 
# Введите данные вашей бд для
# подключения. Где username - пользователь в вашей БД, password - пароль пользователя,
# localhost:5432 - сервер вашей БД и порт соответственно, dbName - имя базы данных.
# ! Эти данные замените на необходимые перед запуском скрипта!!!

# * Создает файл config/config.json связанный с .env
echo '{
  "development": {
    "use_env_variable": "DB_URL",
    "host": "127.0.0.1",
    "dialect": "postgres"
  },
  "test": {
    "username": "root",
    "password": null,
    "database": "database_test",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "production": {
    "username": "root",
    "password": null,
    "database": "database_production",
    "host": "127.0.0.1",
    "dialect": "mysql"
  }
}'> config/config.json

npx sequelize db:create #создается база данных по настройкам выше


# * этот блок создает скрипт для проверки подключения БД
echo "const { sequelize } = require('./models');

module.exports = async () => {
  try {
    await sequelize.authenticate();
    console.log('База данных успешно подключена!');
  } catch (error) {
    console.error('База не подключена :(', error.message);
  }
};" > db/dbCheck.js 


# * Создание исполниетельного файла сервера по умолчанию app.js если надо сменить название,
# * сделайте это в конце блока.
echo "require('dotenv').config(); // подключение переменных env

const express = require('express'); // подключение  express
const morgan = require('morgan'); // подключение  morgan
const hbs = require('hbs'); // подключение  handlebars
const path = require('path');

const dbCheck = require('./db/dbCheck'); // подключение скрипта проверки соединения с БД

const { PORT } = process.env; // получение переменных env, в данный момент только PORT

const app = express(); // создание версии сервера express'a

dbCheck(); // вызов функции проверки соединения с базоый данных

app.set('view engine', 'hbs'); // настройка отрисовщика, в данный момент это HBS
// app.set('views', path.join(__dirname, 'views')); // раскоментить если не используются partials
hbs.registerPartials(\`\${__dirname}/views/partials\`); // закоментить если не используются partials

app.use(morgan('dev')); // добавление настроек и инициализация morgan

app.use(express.urlencoded({ extended: true })); // добавление отлова post запросов.
app.use(express.json()); // парсинг post запросов в json.

// здесь ваш код.


// ! запуск сервера где PORT это порт вашего сервера.
// ! если не подключали .env то замените на цифры(например по умолчанию 3000)
app.listen(PORT, () => {
  console.log(\`Сервер запущен на порте \${PORT}! \`);
});" > app_release.js # <=== название файла можно сменить на то которое вам нужно.


echo '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  {{{body}}}
</body>
</html>' > views/layout.hbs

mkdir -p views/partials 

echo '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  {{{body}}}
</body>
</html>' > views/layout.hbs
