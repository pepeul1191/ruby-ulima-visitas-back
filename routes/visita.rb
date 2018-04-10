class MyApp < Sinatra::Base
  get '/visita/listar' do
    Evento.all.to_json
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
        :movito => visita['motivo'],
        :dia => visita['hora_inicio'],
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
end
