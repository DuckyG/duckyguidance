require 'rake'
require 'net/scp'
namespace :images do
  task :upload, :school, :folder do |t, args|

    school = args[:school]
    folder = args[:folder]
    destination = "/var/www/images.duckyg.com"
    Net::SCP.start("images.duckyg.com", "dseaver86") do |scp|

      Dir.foreach(folder) do |filename|
        unless ['.','..'].include? filename
          new_name = Digest::MD5.hexdigest(school + File.basename(filename,".jpg"))
          puts "#{filename} => #{new_name}"
          scp.upload! "#{folder}/#{filename}", "#{destination}/#{new_name}.jpg"
        end
      end
    end
  end
end
