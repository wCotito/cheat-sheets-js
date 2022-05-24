#!/bin/bash

# Для того что бы все сработало:
# 1) Сохраняете себе этот файл и кидаете его в корень нового проекта.
# 2) chmod +x newproject.sh  // файл по умолчанию не исполняемый, перед запуском выполнить эту команду в консоли где расположен файл,
# для его инициализации.
# P.S. В дальнейшем файл не нужно каждый раз инициализировать, достаточно просто кинуть в корень проекта и запустить.
# 3) Профит! Теперь файл можно запускить в корне любого проекта введя ./newproject.sh в консоли.

npm init -y
# npm i -D jest #раскоментить если нужен jest
npm i -D eslint
# npm i -D eslint-plugin-jest  #раскоментить если нужен jest
npm i -D eslint-config-airbnb-base
npm i -D eslint-plugin-import
npx gitignore node




echo 'module.exports = {
  env: {
    //browser: true, // раскоментить если нужнен еслинт под браузер
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


