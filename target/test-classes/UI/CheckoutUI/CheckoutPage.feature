@ignore
Feature: Reusable Page Actions for the Inventory Page or
	Background:
		* def checkoutPage = read('classpath:UI/CheckoutUI/saucedemo-CheckoutPage.json')

	@action_goToCheckoutStepOne
	Scenario: Action - click checkout button, go to checkout step 1 page
		* click(checkoutPage.checkoutBtn)

	@action_fillCheckoutInfo
	Scenario: Action - fill checkout form
		* input(checkoutPage.firstNameInput, firstName)

		* input(checkoutPage.lastNameInput, lastName)

		* input(checkoutPage.postalCodeInput, postalCode)

		* click(checkoutPage.continueBtn)

	@action_finishCheckout
	Scenario: Action - finish check out procedure
		* click(checkoutPage.finishBtn)
