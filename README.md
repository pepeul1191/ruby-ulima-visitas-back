# Visitas Ruby Sinatra - MongoDB


### Antes de usar

  $ bundler install

### Rutas

  +

### Backup y Restore la Base de Datos Mongo

Para realizar un backup de un base de datos incluyendo los stored functions.

    $ mongodump --db visitas --out db

Para restaurar

    $ mongorestore -d visitas db/visitas

# Fuentes:

+ https://github.com/Wixel/Frank-Sinatra
+ https://github.com/jeremyevans/sequel
+ http://sequel.jeremyevans.net/rdoc/files/doc/dataset_filtering_rdoc.html
+ http://sequel.jeremyevans.net/rdoc/files/doc/cheat_sheet_rdoc.html
+ https://stackoverflow.com/questions/6916626/sinatra-helper-in-external-file
