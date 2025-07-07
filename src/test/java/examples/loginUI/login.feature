Feature: Login functionality in saucedemo.com

	Scenario: Login with valid
	* configure driver = { type: 'chrome' }
		Given driver "https://www.saucedemo.com/"
		And input("//*[@id='user-name']", "standard_user")
		And input("//*[@id='password']", "secret_sauce")
		When click("//*[@id='login-button']")
		# Then match driver.title == "Swag Labs"
		# And click("//*[@id='inventory_container']/div/div[1]/div[3]/button")

	Scenario: Login with invalid
		Given driver "https://www.saucedemo.com/"
		And input("//*[@id='user-name']", "standard_user")
		And input("//*[@id='password']", "wrong_secret_sauce")
		When click("//*[@id='login-button']")

