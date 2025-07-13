@ignore
Feature: Reusable Page Actions for the Inventory Page or
	Background:
		* def homePage = read('classpath:UI/HomePageUI/saucedemo-HomePage.json')

	@action_sortProducts
	Scenario: Action - Sort the product list
		* driver.waitFor(homePage.sortBtn)
		And select(homePage.sortBtn, sortOption)

		# * click(homePage.sortBtn)

		# # Bước 2: Xây dựng locator động cho thẻ <option> chúng ta muốn click.
		# # Locator này sẽ tìm một thẻ <option> có thuộc tính 'value' bằng với giá trị
		# # 'sortOption' được truyền vào (ví dụ: 'za', 'lohi').
		# * def optionLocator = `option[value=${sortOption}]`

		# # Bước 3: Click vào thẻ <option> cụ thể đó.
		# # Đây là hành động mô phỏng người dùng thật và sẽ kích hoạt sự kiện 'onChange'.
	    # * click(optionLocator)

		* delay(2000)

	@action_addProductToCart
	Scenario: Action - Add a specific product to the cart

		* def buttonIdValue = 'add-to-cart-' + productName.toLowerCase().replace(/ /g, '-')
		* def buttonXpath = `//*[@id='${buttonIdValue}']`

		When click(buttonXpath)


	@action_verifyCartBadge
	Scenario: Action - Verify the cart badge count

		# Then match text('.shopping_cart_badge') == '<count>'
		Then match text(homePage.shoppingCartBtn) == count


	@action_openBurgerMenu
	Scenario: Action - Open burger menu
		* click(homePage.burgerMenuBtn)
		# * waitFor(homePage.menuWrapShown)

	@action_logoutBtn
	Scenario: Action - Logout
		# * click(homePage.burgerMenuBtn)
		# * waitFor(homePage.menuWrapShown)
		* call read('HomePage.feature@action_openBurgerMenu')
		* waitFor(homePage.logoutBtn)
		* click(homePage.logoutBtn)


	@action_aboutBtn
	Scenario: Action - go to about page
		* click(homePage.burgerMenuBtn)
		# * waitFor(homePage.menuWrapShown)
		* waitFor(homePage.aboutBtn)
		* click(homePage.aboutBtn)


	@action_resetStateLink
	Scenario: Action - reset
		* click(homePage.burgerMenuBtn)
		# * waitFor(homePage.menuWrapShown)
		* waitFor(homePage.resetStateLink)
		* click(homePage.resetStateLink)

	@action_closeMenuBtn
	Scenario: Action - close menu
		* waitFor(homePage.closeMenuBtn)
		* click(homePage.closeMenuBtn)
		* waitFor(homePage.menuWrapHidden)

	@action_verifyMenuIsHidden
	Scenario: Action - Verify that the burger menu is hidden
		* def menuIsHidden = exists(homePage.menuWrapHidden)
		* match menuIsHidden == true


