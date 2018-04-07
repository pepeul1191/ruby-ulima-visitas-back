require_relative './database'

class Empleado
  include ::ActiveModel::Serialization
  include ::ActiveModel::Serializers::Xml
  include ::ActiveModel::Serializers::JSON
  include MongoMapper::EmbeddedDocument

  key :empleado_id, Integer
  key :codigo_empleado, Integer
  key :dni, String
  key :nombres, String
  key :paterno, String
  key :materno, String
  key :correo_personal, String
  key :correo_laboral, String
  key :cargo, String
  key :telefono, String
end

class Visitante
  include ::ActiveModel::Serialization
  include ::ActiveModel::Serializers::Xml
  include ::ActiveModel::Serializers::JSON
  include MongoMapper::EmbeddedDocument

  key :dni, String
  key :nombres, String
  key :paterno, String
  key :materno, String
  key :telefonos, String
  key :correos, String
  key :placa, String
  key :vehiculo, String
end

class EmpleadoVisitante
  include ::ActiveModel::Serialization
  include ::ActiveModel::Serializers::Xml
  include ::ActiveModel::Serializers::JSON
  include MongoMapper::Document

  one :empleados
  one :Visitantes
  key :movito, String
  key :dia, Time
  key :hora, Time
  key :creacion, Time
end
