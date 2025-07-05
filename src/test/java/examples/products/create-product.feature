Feature: dummyjson.com - Products API - POST a new product

Background:
	* url 'https://dummyjson.com/products'

Scenario: Successfully create a product

	Given path 'add'

	And request
	"""
	{
	"title": "Artisan Bread",
	"price": 59.99,
	}
	"""

	When method post

	Then status 201

	And print response
