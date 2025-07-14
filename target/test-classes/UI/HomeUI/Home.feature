Feature: Business-level tests for the Inventory Page

	Background:
		* configure driver = { type: 'chrome', show: true, addOptions: ['--disable-features=PasswordManager', '--incognito'] }
		* driver saucedemoURL

		# Login before we get into any of these test cases
		* call read("classpath:UI/LoginUI/LoginPage.feature@action_attemptLogin") {username: 'standard_user', password: 'secret_sauce'}

		* def homePage = read('classpath:UI/HomeUI/saucedemo-HomePage.json')

		# Wait for page fully
		* retry(5, 10000).waitFor(homePage.inventoryContainer)
		* retry(5, 10000).waitForUrl(homePage.url)


	# @ignore
	Scenario: Add a single product to cart and verify badge count
		When call read('HomePage.feature@action_addProductToCart') { productName: 'Sauce Labs Backpack' }
		When call read('HomePage.feature@action_verifyCartBadge') { count: '1' }


	# @ignore
	Scenario: Sort products from Z to A and verify the first item

		When call read('HomePage.feature@action_sortProducts') { sortOption: 'za' }
		* delay(1000)
		* def firstName = driver.text(homePage.productNames)


		Then match firstName == 'Test.allTheThings() T-Shirt (Red)'


	# @ignore
	Scenario: Verify the sort (Z to A) data integrity by compare sorted list
		When call read('HomePage.feature@action_sortProducts') { sortOption: 'za' }

		* def uiProductNames = scriptAll(homePage.productNames, 'e => e.innerText')

		# * def originalProductNames = uiProductNames.slice(0)
		* def expectedSortedNames = uiProductNames.slice(0)

		* eval expectedSortedNames.sort()
		* eval expectedSortedNames.reverse()
		* print 'UI List:', uiProductNames
		* print 'Expected List:', expectedSortedNames

		Then match uiProductNames == expectedSortedNames

	# @ignore
	Scenario: Verify the sort (Price low to high) data integrity by compare sorted list
		When call read('HomePage.feature@action_sortProducts') { sortOption: 'lohi' }

		* def uiPricesAsText = scriptAll(homePage.productPrices, 'e => e.innerText')
		* def uiPricesAsNumbers = karate.map(uiPricesAsText, s => parseFloat(s.substring(1)))

		# Create a copy
		* def expectedSortedPrices = uiPricesAsNumbers.slice(0)
		# Sort array of float
		* eval expectedSortedPrices.sort((a, b) => a - b)
		* print 'Expected List:', expectedSortedPrices
		# * def uiPricesAsText = scriptAll(homePage.productPrices, 'e => e.innerText')
		* print 'UI List:', uiPricesAsText
		* print 'UI Prices (as numbers):', uiPricesAsNumbers

		Then match uiPricesAsNumbers == expectedSortedPrices


	# @ignore
	Scenario Outline: Verify product sorting functionality
		When call read('HomePage.feature@action_sortProducts') { sortOption: '<sortOptionValue>' }

		* def allProductNames = scriptAll(homePage.productNames, 'e => e.innerText')

		* def firstName = allProductNames[0]
		* def lastName = allProductNames[allProductNames.length - 1]
		* print(allProductNames)
		* print(firstName)
		* print(lastName)

		Then match firstName == expectedFirstName
		And match lastName == expectedLastName

		# Bảng Examples: Mỗi hàng là một bài test riêng cho một tùy chọn sắp xếp.
		Examples:
			| description         | sortOptionValue | expectedFirstName                     | expectedLastName                      |
			| Sort Name (Z to A)  | za            | Test.allTheThings() T-Shirt (Red)   | Sauce Labs Backpack                 |
			| Sort Name (A to Z)  | az            | Sauce Labs Backpack                 | Test.allTheThings() T-Shirt (Red)   |
			| Sort Price (low-hi) | lohi          | Sauce Labs Onesie                   | Sauce Labs Fleece Jacket            |
			| Sort Price (hi-low) | hilo          | Sauce Labs Fleece Jacket            | Sauce Labs Onesie                   |


	# Test burger menu functions
	# @ignore
	Scenario: Open and close burger menu
		When call read('HomePage.feature@action_openBurgerMenu')
		And call read('HomePage.feature@action_closeMenuBtn')


	# @ignore
	Scenario: Logout
		* def cookiesAfterLogin = driver.cookies
		* print cookiesAfterLogin

		* def saucedemoCookie = { name: 'session-username', value: 'standard_user' }
		# And match driver.cookies contains '#(^saucedemoCookie)'

		And call read('HomePage.feature@@action_logoutBtn')

		Then match driver.cookies !contains '#(^saucedemoCookie)'


	# @ignore
	Scenario: Check About Link
		When call read('HomePage.feature@action_aboutBtn')

		Then match driver.url == 'https://saucelabs.com/'


	# @ignore
	Scenario: Reset state
		# Add to cart 1 product to show shopping cart badge
		When call read('HomePage.feature@action_addProductToCart') { productName: 'Sauce Labs Backpack' }
		Then match exists(homePage.shoppingCartBadge) == true

		When call read('HomePage.feature@action_resetStateLink')
		Then match exists(homePage.shoppingCartBadge) == false

	# @ignore
	Scenario: Go to product page
		When call read('classpath:UI/HomeUI/HomePage.feature@action_clickFirstProduct')
		Then match driver.url contains '/inventory-item.html?id='
		And call read('classpath:UI/HomeUI/HomePage.feature@action_backToProduct')
