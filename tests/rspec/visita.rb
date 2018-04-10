# encoding: utf-8
require_relative 'app'
require 'json'

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
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado la visita')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def editar
  RSpec.describe App do
    describe '2. Editar visita: ' do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Editar visita' do
        id = '5acccc29ef09513f1c000001'
        visitante = {
          :dni => '70241720',
          :nombres => 'José Jesús PPPP',
          :paterno => 'Valdivia PPPP',
          :materno => 'Caballero PPPP',
          :telefono => '9887731975',
          :correos => 'pepito@ulima.pe',
          :placa => 'B6Q-388 adfadf',
          :vehiculo => 'Hyundai Accent 2018',
        }.to_json
        contacto = {
          :dni => 'Biopolímero a partir del almidón de papaya',
          :empleado_id => 2,
          :codigo_empleado => 1,
          :nombres => 'Karry Felix',
          :paterno => 'Mickleburgh',
          :materno => 'XD',
          :cargo => 'Secretaria',
          :telefon => '987731000',
          :correo => 'KaMick@ulima.pe',
        }.to_json
        visita = {
          :motivo => 'Biopolímero a partir del almidón de papaya',
          :dia => '12/12/2015',
          :hora => '10am',
        }.to_json
        url = 'visita/editar?id=' + id + '&visitante=' + visitante + '&contacto=' + contacto + '&visita=' + visita
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha editado la visita')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def eliminar
  RSpec.describe App do
    describe '3. Eliminar visitas: ' do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Eliminar visitas' do
        data = {
          :nuevos => [
          ],
          :editados => [
          ],
          :eliminados => [
            '5acccbd6ef09513d1f000001',
            '5acccc07ef09513dec000001',
            '5acccc13ef09513e4e000001',
            '5acccc1aef09513eae000001',
            '5acccc29ef09513f1c000001',
            '5acccc3eef09513f9b000001',
            '5acccc52ef09514019000001',
          ]
        }.to_json
        url = 'visita/guardar?data=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las visitas')
        expect(test.response.body).to include('success')
      end
    end
  end
end

#editar
#crear
eliminar
