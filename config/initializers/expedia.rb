Expedia.setup do |config|
	config.cid = 55505 # your cid once you go live.
	config.api_key = ENV['expedia_api_key']
	config.shared_secret = ENV['expedia_shared_secret']
	config.locale = 'en_US' # For Example 'de_DE'. Default is 'en_US'
	config.currency_code = 'USD' # For Example 'EUR'. Default is 'USD'
	config.minor_rev = 26 # between 4-26 as of July 2014. Default is 4. 26 being latest
end

$api = Expedia::Api.new
