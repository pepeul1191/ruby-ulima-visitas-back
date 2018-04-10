class MyApp < Sinatra::Base
  get '/visita/listar' do
    rpta = Array.new
    error = false
    execption = nil
    begin
      empleados_visitas = EmpleadoVisitante.all
      empleados_visitas.each do |empleado_visita|
        temp = Hash.new
        _id = empleado_visita._id.to_s
        empleado = empleado_visita.empleado.paterno + ' ' + empleado_visita.empleado.materno + ', ' + empleado_visita.empleado.nombres
        dni_visitante = empleado_visita.visitante.dni
        visitante = empleado_visita.visitante.paterno + ' ' + empleado_visita.visitante.materno + ', ' + empleado_visita.visitante.nombres
        dia = empleado_visita.dia
        hora = empleado_visita.hora
        motivo = empleado_visita.motivo
        temp['id'] = _id
        temp['empleado'] = empleado
        temp['dni_visitante'] = dni_visitante
        temp['visitante'] = visitante
        temp['dia'] = dia
        temp['hora'] = hora
        temp['motivo'] = motivo
        rpta.push(temp)
      end
      rpta.to_json
    rescue Exception => e
      error = true
      execption = e
    end
    if error == false
      return rpta.to_json
    else
      status 500
      puts execption.backtrace
      return {
        :tipo_mensaje => 'error',
        :mensaje =>
          [
            'Se ha producido un error en listar la visitas',
            execption.message
          ]
        }.to_json
    end
  end

  get '/visita/obtener/:visita_id' do
    rpta = nil
    error = false
    execption = nil
    begin
      id = params['visita_id']
      rpta = EmpleadoVisitante.find(BSON::ObjectId.from_string(id))
    rescue Exception => e
      error = true
      execption = e
    end
    if error == false
      return rpta.to_json
    else
      status 500
      puts execption.backtrace
      return {
        :tipo_mensaje => 'error',
        :mensaje =>
          [
            'Se ha producido un error en listar la visitas',
            execption.message
          ]
        }.to_json
    end
  end

  post '/visita/crear' do
    visitante = JSON.parse(params[:visitante])
    contacto = JSON.parse(params[:contacto])
    visita = JSON.parse(params[:visita])
    error = false
    execption = nil
    evento = nil
    begin
      empleado_visita = EmpleadoVisitante.create(
        :empleado => contacto,
        :visitante => visitante,
        :motivo => visita['motivo'],
        :dia => visita['dia'],
        :hora => visita['hora'],
        :creacion => Time.new,
      )
      empleado_visita.save
    rescue Exception => e
      error = true
      execption = e
    end
    if error == false
      return {
        :tipo_mensaje => 'success',
        :mensaje =>
          [
            'Se ha registrado la visita',
            empleado_visita.id.to_s
          ]
        }.to_json
    else
      status 500
      return {
        :tipo_mensaje => 'error',
        :mensaje =>
          [
            'Se ha producido un error en guardar la nueva visita',
            execption.message
          ]
        }.to_json
    end
  end

  post '/visita/editar' do
    id = params[:id]
    visitante = JSON.parse(params[:visitante])
    contacto = JSON.parse(params[:contacto])
    visita = JSON.parse(params[:visita])
    error = false
    execption = nil
    empleado_visita = nil
    begin
      empleado_visita = EmpleadoVisitante.find(BSON::ObjectId.from_string(id))
      empleado_visita.empleado = contacto
      empleado_visita.visitante = visitante
      empleado_visita.motivo = visita['motivo']
      empleado_visita.dia = visita['hora_inicio']
      empleado_visita.hora = visita['hora']
      empleado_visita.dia = visita['dia']
      empleado_visita.save
    rescue Exception => e
      error = true
      execption = e
    end
    if error == false
      return {
        :tipo_mensaje => 'success',
        :mensaje =>
          [
            'Se ha editado la visita'
          ]
        }.to_json
    else
      status 500
      return {
        :tipo_mensaje => 'error',
        :mensaje =>
          [
            'Se ha producido un error en guardar la visita editada',
            execption.message
          ]
        }.to_json
    end
  end

  post '/visita/guardar' do
    data = JSON.parse(params[:data])
    eliminados = data['eliminados']
    rpta = []
    array_nuevos = []
    error = false
    execption = nil
    begin
     if eliminados.length != 0
       EmpleadoVisitante.destroy(eliminados)
     end
    rescue Exception => e
     error = true
     execption = e
    end
    if error == false
     return  {
       :tipo_mensaje => 'success',
       :mensaje =>
          [
            'Se ha registrado los cambios en las visitas',
            array_nuevos
          ]
      }.to_json
    else
     status 500
     return {
       :tipo_mensaje => 'error',
       :mensaje =>
         [
           'Se ha producido un error en guardar la colección de visitas',
           execption.message
         ]
       }.to_json
    end
  end
end
