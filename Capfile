Dir['recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy'

# add all applications as "stages" required by multistage extension
#
applications = Dir['config/deploy/*.rb'].map { |file| File.basename(file, ".rb") }
set :stages, applications
require 'capistrano/ext/multistage' 

# add all vendor_paths to the look up path
#
vendor_paths =  Dir["#{File.dirname(__FILE__)}/vendor/**"].map do |dir| 
  File.directory?(lib = "#{dir}/lib") ? lib : dir
end
$:.concat(vendor_paths)

require 'backup'