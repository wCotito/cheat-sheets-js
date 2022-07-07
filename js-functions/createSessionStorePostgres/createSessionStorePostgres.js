/*
Файл для создания таблицы для хранения сессий в БД postgres с помощью пакета connect-pg-simple
*/

require('dotenv').config();

const { Sequelize } = require('sequelize');

const { DATABASE_URL } = process.env;

// ищет env переменную с данными подключения, если её у вас нет,
// то введите данные подключения к БД тут.
const sequelizeDC = new Sequelize(DATABASE_URL || 'postgres://username:password@localhost:5432/dbName');

// Создание таблицы для хранения сессий в соответствии с документацией пакета connect-pg-simple
// ! Пред запуском файла необходимо создать БД и настроить её подключение.
const createSessionStorePostgres = async () => {
  try {
    await sequelizeDC.query(`CREATE TABLE "session" (
        "sid" varchar NOT NULL COLLATE "default",
        "sess" json NOT NULL,
        "expire" timestamp(6) NOT NULL
      )
      WITH (OIDS=FALSE);
      ALTER TABLE "session" ADD CONSTRAINT "session_pkey" PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE;

      CREATE INDEX "IDX_session_expire" ON "session" ("expire");`);
    console.log('Таблица для сессий создана');
  } catch (error) {
    console.log('Таблица для сессий НЕ СОЗДАНА!!');
    console.log(error.message);
  }
};

createSessionStorePostgres();
