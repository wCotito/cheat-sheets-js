#!/bin/bash

# * При запуске данного скрипта будет создано приложение React с дефолтными настройками, 
# * сервер на express, база данных к нему на postgres, сессии в session-file-store

# ! Перед тем как запустить скрипт поменяйте в нем данные подключения к БД!!
# ! И её название!!

# ? Если каккая то настройка не нужна, просто закоментируйте её

# Для того что бы все сработало:
# 1) Сохраняете себе этот файл и кидаете его в корень нового проекта.
# 2) chmod +x react-express-sessionInFilestore.sh  // файл по умолчанию не исполняемый, перед запуском выполнить эту команду в консоли где расположен файл,
# для его инициализации.
# P.S. В дальнейшем файл не нужно каждый раз инициализировать, достаточно просто кинуть в корень проекта и запустить.
# 3) Профит! Теперь файл можно запускить в корне любого проекта введя ./start-server-express.sh в консоли.


# * создает приложение реакт
npx create-react-app client

# * создание папки сервера и переход в него
mkdir -p server
cd server

# ? Далее идет блок создания и настройки сервера

# * Создание скриптов запуска сервера и его инициализация
  echo '{
    "scripts": {
      "test": "echo \"Error: no test specified\" && exit 1",
      "start": "node app.js",
      "dev": "nodemon app.js"
    }
  }' > package.json

  npm init -y

# * Подключение и настройка eslint'та если нужно
npm i -D eslint eslint-config-airbnb-base eslint-plugin-import

echo 'module.exports = {
  env: {
    // browser: true, // раскоментить если нужнен еслинт под браузер
    commonjs: true,
    es2021: true,
    node: true,
    //jest: true,   //раскоментить если использется jest
  },
  extends: [
    "'"airbnb-base"'",
  ],
  parserOptions: {
    ecmaVersion: "'"latest"'",
  },
  plugins: [
    ///"'"jest"'",  //раскоментить если использется jest
  ],
  rules: {
  },
};' > .eslintrc.js

# * Добавление гитигнора
npx gitignore node


npm i  sequelize pg pg-hstore sequelize-cli
npm i  dotenv
npm i  express
npm i  morgan
npm i -D nodemon

# * Для сессий 
npm i express-session
npm i session-file-store

# * для шифровки паролей и т.д.
npm i bcrypt

# * cors - для подключения клиента и сервера
npm i cors

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
echo 'PORT=3100
DATABASE_URL=postgres://username:password@localhost:5432/dbName
COOKIE_NAME=ssid
SESSION_SEED=123dy45' > .env 
# Введите данные вашей бд для
# подключения. Где username - пользователь в вашей БД, password - пароль пользователя,
# localhost:5432 - сервер вашей БД и порт соответственно, dbName - имя базы данных.
# ! Эти данные замените на необходимые перед запуском скрипта!!!

# * Создает файл config/config.json связанный с .env
echo '{
  "development": {
    "use_env_variable": "DATABASE_URL"
  },
  "test": {
    "use_env_variable": "DATABASE_URL"
  },
  "production": {
   "use_env_variable": "DATABASE_URL"
  }
}'> config/config.json

# ! Если не хотите создавать БД при запуске скрипта, то закоментируйте строчку ниже.
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
const cors = require('cors');
const session = require('express-session');
const FileStore = require('session-file-store')(session);
const { PORT, COOKIE_NAME, SESSION_SEED } = process.env; // получение переменных env



const app = express(); // создание версии сервера express'a

const dbCheck = require('./db/dbCheck'); // подключение скрипта проверки соединения с БД
dbCheck(); // вызов функции проверки соединения с базоый данных

const sessionConfig = { // создание объекта с настройками сессии
  store: new FileStore(),
  key: COOKIE_NAME,
  secret: SESSION_SEED,
  resave: false,
  saveUninitialized: false,
  httpOnly: true,
  cookie: { expires: 24 * 60 * 60e3 },
};

app.use(session(sessionConfig)); // подключение сессии


app.use(morgan('dev')); // добавление настроек и инициализация morgan
app.use(cors()); // подключение cors
app.use(express.urlencoded({ extended: true })); // добавление отлова post запросов.
app.use(express.json()); // парсинг post запросов в json.

// здесь ваш код.


// ! запуск сервера где PORT это порт вашего сервера.
// ! если не подключали .env то замените на цифры(например по умолчанию 3000)
app.listen(PORT, () => {
  console.log(\`Сервер запущен на порте \${PORT}! \`);
});" > app.js # <=== название файла можно сменить на то которое вам нужно.




mkdir -p routes
mkdir -p middlewares




echo 'console.log("здесь первый rout");' > routes/rout.js
echo 'console.log("здесь middlewares");' > middlewares/common.js

