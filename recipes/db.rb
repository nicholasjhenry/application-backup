namespace :firsthand do
  namespace :db do
     desc "Backup the application database"
     task :backup do
       # dump the database file
       application_backup_pathname = File.join(application_pathname, 'backup')
       run "mkdir -p #{application_backup_pathname}"

       database, username, password = get_database_config(application_pathname)
       db_backup_filename           = "#{database}.sql.gz"
       db_backup_full_pathname      = File.join(application_backup_pathname, db_backup_filename)
       run "mysqldump -u #{username} -p#{password} --opt #{database} | gzip - > #{db_backup_full_pathname}"

       # download and backup it up
       client_application_backup_pathname = File.join(client_backup_pathname, application)
       client_db_backup_full_pathname     = File.join(client_application_backup_pathname, db_backup_filename)

       get db_backup_full_pathname, client_db_backup_full_pathname
       backup = EngineYard::Backup.new(client_db_backup_full_pathname)
       backup.run
     end
  end
end
