namespace :firsthand do
  namespace :assets do
    desc "Backup assets in the shared directory"
    task :backup do
      full_client_backup_pathname =
        File.join(client_backup_pathname, application)
      shared_pathname             =
        File.join(full_client_backup_pathname, "shared")

      system "mkdir -p #{shared_pathname}"

      # sync the remote directory
      rsync_cmd = "rsync --archive -vv --rsh=ssh"
      system "#{rsync_cmd} #{domain}:#{application_pathname}/shared/public/* #{full_client_backup_pathname}/shared"

      # archive it and back it up
      tar_filename = File.join(full_client_backup_pathname, "shared.tar")
      system "tar -cvf #{tar_filename} #{full_client_backup_pathname}/shared/"
      backup = EngineYard::Backup.new(tar_filename)
      backup.run
    end
  end
end
