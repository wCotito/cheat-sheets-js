Слева тип данных в sequelize справа чему он соответствует в самом postgres`e

# Strings

`DataTypes.STRING`             // VARCHAR(255)

`DataTypes.STRING(1234)`       // VARCHAR(1234)

`DataTypes.STRING.BINARY`      // VARCHAR BINARY

`DataTypes.TEXT`               // TEXT

`DataTypes.TEXT('tiny')`       // TINYTEXT

`DataTypes.CITEXT`             // CITEXT          PostgreSQL and SQLite only.

`DataTypes.TSVECTOR`           // TSVECTOR        PostgreSQL only.


# Boolean

`DataTypes.BOOLEAN`            // TINYINT(1)

# Numbers

`DataTypes.INTEGER `           // INTEGER

`DataTypes.BIGINT`             // BIGINT

`DataTypes.BIGINT(11)`         // BIGINT(11)

`DataTypes.FLOAT`              // FLOAT

`DataTypes.FLOAT(11)`          // FLOAT(11)

`DataTypes.FLOAT(11, 10)`      // FLOAT(11,10)


`DataTypes.REAL`               // REAL            PostgreSQL only.

`DataTypes.REAL(11)`           // REAL(11)        PostgreSQL only.

`DataTypes.REAL(11, 12)`       // REAL(11,12)     PostgreSQL only.


`DataTypes.DOUBLE`             // DOUBLE

`DataTypes.DOUBLE(11)`         // DOUBLE(11)

`DataTypes.DOUBLE(11, 10)`     // DOUBLE(11,10)


`DataTypes.DECIMAL`            // DECIMAL

`DataTypes.DECIMAL(10, 2)`     // DECIMAL(10,2)




Данные взяты с https://sequelize.org/docs/v6/core-concepts/model-basics/#data-types
