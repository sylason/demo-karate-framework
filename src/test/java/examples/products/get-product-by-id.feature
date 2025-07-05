Feature: dummyjson.com - Products API - GET a single product by Id

Background:
	* url 'https://dummyjson.com'

Scenario: Successfully get product by using Id

	Given path 'products/1'

	When method get

	Then status 200

	And print response

	And match response.id == 1
	And match response ==
	"""
	{
	"id": "#number",
	"title": "#string",
	"description": "#string",
	"category": "#string",
	"price": "#number",
	"discountPercentage": "#number",
	"rating": "#number",
	"stock": "#number",
	"tags": "#[] #string",
	"brand": "#string",
	"sku": "#string",
	"weight": "#number",
	"dimensions": {
		"width": "#number",
		"height": "#number",
		"depth": "#number"
	},
	"warrantyInformation": "#string",
	"shippingInformation": "#string",
	"availabilityStatus": "#string",
	"reviews": "#[]",
	"returnPolicy": "#string",
	"minimumOrderQuantity": "#number",
	"meta": "#object",
	"thumbnail": "#string",
	"images": "#[] #string"
	}
	"""



Scenario: 404 Response when there is no existed Id
	Given path 'products/9999'
	When method get
	Then status 404
	And print response

Scenario: Test if Id can be 0
	Given path 'products/0'
	When method get
	Then status 404
	And print response

# Scenario: Boundary value testing with negative ID
# 	Given url 'products/-1'
# 	When method get
# 	Then status 404
# 	And print response

