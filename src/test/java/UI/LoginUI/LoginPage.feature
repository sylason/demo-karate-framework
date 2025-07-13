@ignore
Feature: Login functionality in saucedemo (using JSON as page object model)
	Background:
		* def loginPage = read('classpath:UI/LoginUI/saucedemo-LoginPage.json')

	@action_attemptLogin
	Scenario: Action - Attempt to log in with given credentials

		And input(loginPage.usernameInput, username)

		And input(loginPage.passwordInput, password)

		When click(loginPage.loginButton)

