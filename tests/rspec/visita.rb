def crear
  RSpec.describe App do
    describe '1. Crear visita: ' do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Crear visita' do
        visitante = {
          :dni => '70241720',
          :nombres => 'José Jesús',
          :paterno => 'Valdivia',
          :materno => 'Caballero',
          :telefono => '9887731975',
          :correos => 'pepito@ulima.edu.pe',
          :placa => 'B6Q-388',
          :vehiculo => 'Hyundai Accent 2011',
        }.to_json
        contacto = {
          :dni => 'Biopolímero a partir del almidón de papa',
          :empleado_id => 2,
          :codigo_empleado => 1,
          :nombres => 'Karry Felix',
          :paterno => 'Mickleburgh',
          :materno => 'Jimpson',
          :cargo => 'Secretaria',
          :telefon => '987731000',
          :correo => 'KaMick@ulima.edu.pe',
        }.to_json
        visita = {
          :motivo => 'Biopolímero a partir del almidón de papa',
          :dia => '12/12/2012',
          :hora => '10am',
        }.to_json
        url = 'visita/crear?visitante=' + visitante + '&contacto=' + contacto + '&visita=' + visita
        test = App.new(url)
        test.post()
        if test.response.code != 200 then
          puts test.response.body
        end
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado la visita')
        expect(test.response.body).to include('success')
      end
    end
  end
end
