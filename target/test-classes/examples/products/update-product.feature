Feature: dummyjson.com - Products API - PUT a single product by Id
Background:
	* url 'https://dummyjson.com/products'

Scenario: Successfully updated a product
	Given path '1'
	And request
	"""
	{
	"title": "Iphone 20 Pro Max",
	"price": 19999.99
	}
	"""

	When method put

	Then status 200

	And print response

	And match response.id == 1
	And match response.title == 'Iphone 20 Pro Max'
	And match response.price == 19999.99


Scenario: Error updating product that does not exist
	Given path '999'

	And request { "title": "Product That Does Not Exist" }

	When method put

	Then status 404

	And match response.message == "Product with id '999' not found"


	