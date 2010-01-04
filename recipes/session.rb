# This task is not used in the backup series, but here for convience. For
# clearing session the application itself is reponsible. See Firsthand 
# Powertools.
#
namespace :firsthand do
  namespace :sessions do
    desc "Removes old session files"
    task :clear do
      database, username, password = get_database_config(application_pathname)
      history_in_days = 14
      run "mysql -u #{username} -p#{password} -D #{database} -e 'DELETE FROM sessions WHERE datediff(now(), updated_at) > #{history_in_days}' "
    end
  end
end