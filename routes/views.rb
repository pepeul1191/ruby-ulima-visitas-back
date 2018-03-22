class MyApp < Sinatra::Base
  get '/home' do
    locals = {
      :csss => [
        'bower_components/bootstrap/dist/css/bootstrap.min',
        'bower_components/font-awesome/css/font-awesome.min',
      ],
      :jss => [
        'bower_components/jquery/dist/jquery.min',
        'bower_components/bootstrap/dist/js/bootstrap.min',
      ],
      :tiempo => Time.now
    }
		erb :'home/index', :layout => :'layouts/blank', :locals => locals
  end
end
