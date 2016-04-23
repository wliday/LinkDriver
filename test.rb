require 'json'
puts File.dirname(__FILE__)
puts File.expand_path(File.dirname(__FILE__))
puts File.expand_path(File.dirname(__FILE__))
current_dir = File.expand_path(File.dirname(__FILE__))
file = File.read("#{current_dir}/.config_file_path")
config_file_path = JSON.parse(file) 


