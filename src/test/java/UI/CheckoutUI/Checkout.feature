Feature: Business-level tests for the Inventory Page

	Background:
		* configure driver = { type: 'chrome', show: true, addOptions: ['--disable-features=PasswordManager', '--incognito'] }
		* driver saucedemoURL

		# Login before we get into any of these test cases
		* call read("classpath:UI/LoginUI/LoginPage.feature@action_attemptLogin") {username: 'standard_user', password: 'secret_sauce'}

		* def homePage = read('classpath:UI/HomeUI/saucedemo-HomePage.json')
		* def checkoutPage = read('classpath:UI/CheckoutUI/saucedemo-CheckoutPage.json')

		# Wait for page fully
		* retry(5, 10000).waitFor(homePage.inventoryContainer)
		* retry(5, 10000).waitForUrl(homePage.url)


	# @ignore
	Scenario: Full checkout process with "Sauce Labs Backpack" and return
		* def productNameToBuy = 'Sauce Labs Backpack'
		# Add 1 product into cart
		When call read('classpath:UI/HomeUI/HomePage.feature@action_addProductToCart') { productName: 'Sauce Labs Backpack' }
		When call read('classpath:UI/HomeUI/HomePage.feature@action_verifyCartBadge') { count: '1' }

		# Go to cart and confirm item in cart
		When call read('classpath:UI/HomeUI/HomePage.feature@action_goToCart')
		Then match driver.text(checkoutPage.FirstItemNameInCart) == productNameToBuy

		# Go to checkout page, fill checkout form
		When call read('classpath:UI/CheckoutUI/CheckoutPage.feature@action_goToCheckoutStepOne')
		And call read('classpath:UI/CheckoutUI/CheckoutPage.feature@action_fillCheckoutInfo') {firstName: 'Sauce', lastName: 'Demo', postalCode: '111' }

		# Finish checkout procedure
		When call read('classpath:UI/CheckoutUI/CheckoutPage.feature@action_finishCheckout')
		* driver.waitFor(checkoutPage.thankYouHeader)
		Then match driver.text(checkoutPage.thankYouHeader) == 'Thank you for your order!'



