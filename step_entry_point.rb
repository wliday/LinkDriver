require 'watir-webdriver'
require 'set'
require 'yaml'
require 'logger'
require_relative 'linkedin_page'
require_relative 'records'

# initialize
config_file_path = YAML::load_file '.config_file_path'
config_reader = YAML::load_file config_file_path["path"]
browser = Watir::Browser.new :chrome
logger = Logger.new(STDOUT)
linkedin_page = LinkedinPage.new(browser, logger)
records = Records.new(config_reader)
DELIMITER = ','


# open linkedin 
linkedin_page.go_to_login_page config_reader['server_url']

# login account
linkedin_page.login_page_username.set config_reader["login"]["username"]
linkedin_page.login_page_password.set config_reader["login"]["password"]
linkedin_page.login_page_submit.click
linkedin_page.index_page.wait_until_present

# Set search keyword
linkedin_page.search_box.set config_reader["search"]["keywords"]
linkedin_page.search_button.click
linkedin_page.search_result_page.wait_until_present

# Set filters
filters = config_reader["search"]["filters"]
filters.each do |key, value|
	case key
	when 'type'
		linkedin_page.search_type_selector(value).click unless value.nil?
		Watir::Wait.while {linkedin_page.search_loading}
	when 'relationship_to_uncheck'
		value.split(DELIMITER).each do |val|
			linkedin_page.search_relationship_selector(val).clear
			Watir::Wait.while {linkedin_page.search_loading}
		end
	when 'relationship_to_check'
		value.split(DELIMITER).each do |val|
			linkedin_page.search_relationship_selector(val).set
			Watir::Wait.while {linkedin_page.search_loading}
		end		
	when 'location'
		value.split(DELIMITER).each do |val|
			linkedin_page.search_locations(val).set
			Watir::Wait.while {linkedin_page.search_loading}
		end	
	else
		logger.warn("Some of your filters are ignored")
	end
end

# start sending invitation
index = 0
while true
	results = linkedin_page.search_results(index)
	if !results.nil?
		results.each_with_index do |li, i|
			index = index + 1
			name = linkedin_page.name_of_person(li)
			description = linkedin_page.description_of_person(li)
			if records.exists?(name, description) then
				logger.info("We already sent invitiation to #{name} before.")
				next
			else
				records.add(name, description)
			end

			if !linkedin_page.blue_button_exists?(li) then	
				logger.debug("can not find blue button for #{name}")
				next
			else
				blue_button = linkedin_page.blue_button(li)
			end

			if blue_button.text == 'Message'
				logger.info("Already Connected with #{name}")
			elsif blue_button.text == 'Follow'
				blue_button.click
				logger.info("Now following #{name}")
			elsif blue_button.text == 'Connect'
				blue_button.when_present.click
				sleep 2
				if linkedin_page.need_email_page?
					browser.back
					logger.info("Need email address to connect with #{name}")
					linkedin_page.search_result_page.wait_until_present
					break
				else
					logger.info("Invitation has been sent to #{name}")
				end
			end
		end

		# navigate to next page
		if index > (results.length - 1)
			if linkedin_page.next_page.exists? then
				linkedin_page.next_page.click
				index = 0
				logger.info("next page loading...")
				Watir::Wait.while {linkedin_page.search_loading}
			else
				break
			end
		end
	end
end
browser.close
records.file_close



