Feature: dummyjson.com - Products API - DELETE a product by Id
Background:
	* url 'https://dummyjson.com/products'

Scenario: Successfully delete a product
  Given path '1'
  When method delete
  Then status 200
  And print response
  And match response.id == 1
  And match response.title == 'Essence Mascara Lash Princess'
  And match response.isDeleted == true
