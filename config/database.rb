require 'mongo_mapper'
require 'activemodel-serializers-xml'

MongoMapper.connection = Mongo::Connection.new('127.0.0.1')
MongoMapper.database = 'visitas'
