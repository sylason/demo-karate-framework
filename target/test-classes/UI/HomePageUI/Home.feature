Feature: Business-level tests for the Inventory Page

	Background:
		* configure driver = { type: 'chrome', show: true, addOptions: ['--disable-features=PasswordManager', '--incognito'] }
		* driver saucedemoURL

		# Login before we get into any of these test cases
		* call read("classpath:UI/LoginUI/LoginPage.feature@action_attemptLogin") {username: 'standard_user', password: 'secret_sauce'}

		* def homePage = read('classpath:UI/HomePageUI/saucedemo-HomePage.json')
		# * driver.waitFor(homePage.homepageURL)


	# @ignore
	Scenario: Add a single product to cart and verify badge count
		When call read('HomePage.feature@action_addProductToCart') { homePage: homePage, productName: 'Sauce Labs Backpack' }
		# Then call read('HomePage.feature@action_verifyCartBadge') { count: '1' }
		* def cartBadgeLocator = homePage.shoppingCartBtn + ' .shopping_cart_badge'
		Then match driver.text(cartBadgeLocator) == '1'
		# Then match exists(homePage.shoppingCartBadge) == true


	@ignore
	Scenario: Sort products from Z to A and verify the first item

		When call read('HomePage.feature@action_sortProducts') { sortOption: '{}Name (Z to A)' }
		# * delay(1000)
		# * def firstItemName = text("div.inventory_item_name >> nth=0")
		# And match firstItemName == 'Test.allTheThings() T-Shirt (Red)'

	@ignore
	Scenario Outline: Verify product sorting functionality
		When call read('HomePage.feature@action_sortProducts') { sortOption: '<sortOptionValue>' }

		# * def allProductNames = driver.text(homePage.productNames)

		# * def firstName = allProductNames[0]
		# * def lastName = allProductNames[allProductNames.length - 1]
		# * print(allProductNames)
		# * print(firstName)
		# * print(lastName)

		# And match firstName == expectedFirstName
		# And match lastName == expectedLastName
		# * delay(100)

		# Bảng Examples: Mỗi hàng là một bài test riêng cho một tùy chọn sắp xếp.
		Examples:
			| description         | sortOptionValue | expectedFirstName                     | expectedLastName                      |
			| Sort Name (Z to A)  | za            | Test.allTheThings() T-Shirt (Red)   | Sauce Labs Backpack                 |
			| Sort Name (A to Z)  | az            | Sauce Labs Backpack                 | Test.allTheThings() T-Shirt (Red)   |
			| Sort Price (low-hi) | lohi          | 'Sauce Labs Onesie                   | Sauce Labs Fleece Jacket            |
			| Sort Price (hi-low) | hilo          | 'Sauce Labs Fleece Jacket            | Sauce Labs Onesie                   |


	# Test burger menu functions
	Scenario: Open and close burger menu
		When call read('HomePage.feature@action_openBurgerMenu')
		* waitFor(homePage.closeMenuBtn)
		When call read('HomePage.feature@action_closeMenuBtn')


	Scenario: Logout
		* def cookiesAfterLogin = driver.cookies
		# And match cookiesAfterLogin['value'] == 'standard_user'
		* print cookiesAfterLogin

		* def saucedemoCookie = { name: 'session-username', value: 'standard_user' }
		And match driver.cookies contains '#(^saucedemoCookie)'

		And call read('HomePage.feature@aciton_logoutBtn')

		* waitFor(saucedemoURL)
		Then match driver.url == saucedemoURL

		And match driver.cookies contains '#(^saucedemoCookie)'


	Scenario: Check About
		When call read('HomePage.feature@action_aboutBtn')

		Then match driver.url == 'https://saucelabs.com/'


	Scenario: Reset state
		# Add to cart 1 product to show shopping cart badge
		When call read('HomePage.feature@action_addProductToCart') { homePage: homePage, productName: 'Sauce Labs Backpack' }
		Then match exists(homePage.shoppingCartBadge) == true

		When call read('HomePage.feature@action_resetStateLink')
		Then match exists(homePage.shoppingCartBadge) == false


