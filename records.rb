require 'set'

class Records
	def initialize(config_reader)
		@config_reader = config_reader
		@records = prepare_records
		@file_write = File.open(@config_reader["records"]["file_name"], "a")
	end

	def exists?(name, description)
		record = generate_record(name, description)
		@records.include?(record)
	end

	def add(name, description)
		record = generate_record(name, description)
		@records.add(record)
		@file_write.puts(record + "\n")
	end

	def file_close
		@file_write.close
	end

	
	private

	def prepare_records
		file_name = @config_reader["records"]["file_name"]
		File.exist?(file_name) ? File.read(file_name).split("\n").to_set : Set.new
	end

	def generate_record(name, description)
		record = name + "-" + description[0, 10];
	end


end