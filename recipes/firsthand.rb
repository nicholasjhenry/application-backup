namespace :firsthand do
  namespace :backup do
    desc "Backups the database and assets"
    task :default do
      # ensure application backup folder exists
      #
      full_client_backup_pathname = 
        File.join(client_backup_pathname, application)
      system "mkdir -p #{full_client_backup_pathname}" 
      
      db.backup
      assets.backup
    end    
  end
  
  # Returns [database, username, password]
  #
  def get_database_config(application_pathname)
    config_file = File.join(application_pathname, 'current', 'config', 'database.yml')
    config      = ""
    run "cat #{config_file}" do |channel, out, data|
      config = YAML.load(data)['production']    
    end

    [config['database'], config['username'], config['password']]
  end  
end  