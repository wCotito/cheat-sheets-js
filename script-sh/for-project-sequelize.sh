#!/bin/bash
#  Файл выпонняет установку sequelize для postgres и cli

# Для того что бы все сработало:
# 1) Сохраняете себе этот файл и кидаете его в корень нового проекта.
# 2) chmod +x for-project-sequelize.sh  // файл по умолчанию не исполняемый, перед запуском выполнить эту команду в консоли где расположен файл.
# P.S. В дальнейшем файл не нужно каждый раз инициализировать, достаточно просто кинуть в корень проекта и запустить.
# 3) Профит! Теперь файл можно запускить в корне любого проекта введя ./for-project-sequelize.sh в консоли.

npm install --save sequelize
npm install --save pg pg-hstore

npm install --save-dev sequelize-cli



echo  `const path = require('path');
 module.exports = {
 'config': path.resolve('config', 'config.json'),
 'models-path': path.resolve('db', 'models'),
 'seeders-path': path.resolve('db', 'seeders'),
 'migrations-path': path.resolve('db', 'migrations')
 };` > .sequelizerc

npx sequelize init
