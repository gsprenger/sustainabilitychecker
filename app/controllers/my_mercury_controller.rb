class MyMercuryController < MercuryController
  http_basic_authenticate_with :name => "iaste", :password => (ENV['ADMIN_PWD'] || 'dev')
end
