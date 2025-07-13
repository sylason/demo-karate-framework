@ignore
Feature: Reusable Page Actions for the Inventory Page or
	Background:
		* def homePage = read('classpath:UI/HomePageUI/saucedemo-HomePage.json')

	@action_sortProducts
	Scenario: Action - Sort the product list
		* waitFor(homePage.sortBtn)
		* script(homePage.sortBtn, "e => { e.value = '" + sortOption + "'; e.dispatchEvent(new Event('change', { bubbles: true })) }")

	@action_addProductToCart
	Scenario: Action - Add a specific product to the cart

		* def buttonIdValue = 'add-to-cart-' + productName.toLowerCase().replace(/ /g, '-')
		* def buttonXpath = `//*[@id='${buttonIdValue}']`

		* retry(5, 10000).waitForEnabled(buttonXpath).click()



	@action_verifyCartBadge
	Scenario: Action - Verify the cart badge count

		# Then match text('.shopping_cart_badge') == '<count>'
		Then match text(homePage.shoppingCartBtn) == count


	@action_openBurgerMenu
	Scenario: Action - Open burger menu
		* waitForEnabled(homePage.burgerMenuBtn).click()
		# * click(homePage.burgerMenuBtn)
		* waitFor(homePage.menuWrapShown)

	@action_logoutBtn
	Scenario: Action - Logout
		* call read('HomePage.feature@action_openBurgerMenu')
		* waitFor(homePage.logoutBtn).click()


	@action_aboutBtn
	Scenario: Action - go to about page
		* call read('HomePage.feature@action_openBurgerMenu')
		# * waitFor(homePage.menuWrapShown)
		* waitFor(homePage.aboutBtn).click()


	@action_resetStateLink
	Scenario: Action - reset
		* call read('HomePage.feature@action_openBurgerMenu')
		# * waitFor(homePage.menuWrapShown)
		* waitFor(homePage.resetStateLink).click()

	@action_closeMenuBtn
	Scenario: Action - close menu
		* waitForEnabled(homePage.closeMenuBtn).click()
		* waitFor(homePage.menuWrapHidden)

	@action_verifyMenuIsHidden
	Scenario: Action - Verify that the burger menu is hidden
		* def menuIsHidden = exists(homePage.menuWrapHidden)
		* match menuIsHidden == true


	@action_clickFirstProduct
	Scenario: Action - Click on the first product in the list
		# * def firstProductLinkLocator = driver.text(homePage.productNames)
		* def firstProductLinkLocator = homePage.productNameLinks

		# * waitFor(firstProductLinkLocator).click()
		# * waitFor(homePage.productNameLinks).click()
		* click(homePage.productNameLinks)

	@action_backToProduct
	Scenario: Action - Click on back to product page
		* waitFor(homePage.backToProductsButton).click()
