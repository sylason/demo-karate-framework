Feature: Login functionality in saucedemo (using JSON as page object model)
	Background:
  * def page = read('classpath:examples/loginUI/saucedemo-loginPage.json')
	* def webURL = page.url
	# * configure driver = { type: 'chromedriver' }
	# * driver page.url

	Scenario: Login with valid
	* configure driver = { type: 'chrome' }
	* driver page.url
		Given driver webURL
		And input(page.usernameInput, "standard_user")
		And input(page.passwordInput, "secret_sauce")
		When click(page.loginButton)
		# Then match driver.title == "Swag Labs"
		# And click("//*[@id='inventory_container']/div/div[1]/div[3]/button")

	Scenario: Login with invalid credentials
		Given driver "https://www.saucedemo.com/"
		And input("//*[@id='user-name']", "standard_user")
		And input("//*[@id='password']", "wrong_secret_sauce")
		When click("//*[@id='login-button']")

