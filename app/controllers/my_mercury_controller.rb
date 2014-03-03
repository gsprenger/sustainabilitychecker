class MyMercuryController < MercuryController
  http_basic_authenticate_with :name => "iaste", :password => IO.read(Rails.root+'.password').chomp
end
