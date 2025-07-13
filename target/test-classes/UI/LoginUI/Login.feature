# @ignore
Feature: Login functionality in saucedemo.com
Background:
	* configure driver = { type: 'chrome' }
	* configure logPrettyResponse = true
	* configure ssl = true
	* configure readTimeout = 10000
	* driver saucedemoURL
	* def loginPage = read('classpath:UI/LoginUI/saucedemo-LoginPage.json')


	# @ignore
	Scenario: Login with valid
		And input("//*[@id='user-name']", "standard_user")
		And input("//*[@id='password']", "secret_sauce")
		When click("//*[@id='login-button']")
		* driver quit

	# @ignore
	Scenario: Login with invalid
		And input("//*[@id='user-name']", "standard_user")
		And input("//*[@id='password']", "wrong_secret_sauce")
		When click("//*[@id='login-button']")
		* driver quit


	# @ignore
	Scenario Outline: Verify login results for different users
		When call read('LoginPage.feature@action_attemptLogin') {username: '<username>',password: '<password>' }

		# * if (type == 'success') { driver.waitForUrl('https://www.saucedemo.com/inventory.html') }
		# * if (type == 'failure') { karate.match(driver.text(loginPage.errorDisplay), message) }
		* eval
		"""
		if (type == 'success') {
		driver.waitForUrl(homepageURL);
		} else {
		karate.match(driver.text(loginPage.errorDisplay), message);
		}
		"""
		Examples:
			| username			| password		| type		| message																		|
			| standard_user		| secret_sauce	| success	|																				|
			| locked_out_user	| secret_sauce	| failure	| Epic sadface: Sorry, this user has been locked out.							|
			| standard_user		| wrong_pass	| failure	| Epic sadface: Username and password do not match any user in this service		|
			| standard_user		|				| failure	| Epic sadface: Password is required											|

