set :application, "dah_extranet"
set :domain, application
set :application_pathname, "/srv/#{application}"

role :web, domain