Feature: dummyjson.com - Products API - GET all products

Background:
	* url 'https://dummyjson.com'

Scenario: Successfully get all products by check types of response fields

	Given path 'products'

	When method get

	Then status 200

	And print response

	And match response ==
    """
    {
      "products": "##array",
      "total": "##number",
      "skip": "##number",
      "limit": "##number"
    }
    """

	# and match each response.products.reviews ==
	# """
	# {
	# 	"rating": "##number",
	# 	"comment": "##string",
	# 	"date": "##string",
	# 	"reviewerName": "##string",
	# 	"reviewerEmail": "##string"
	# }
	# """

	And match each response.products ==
	"""
	{
	"id": "#number",
	"title": "##string",
	"description": "##string",
	"category": "##string",
	"price": "##number",
	"discountPercentage": "##number",
	"rating": "##number",
	"stock": "##number",
	"tags": "##[] ##string",
	"brand": "##string",
	"sku": "##string",
	"weight": "##number",
	"dimensions": {
		"width": "##number",
		"height": "##number",
		"depth": "##number"
	},
	"warrantyInformation": "##string",
	"shippingInformation": "##string",
	"availabilityStatus": "##string",
	"reviews": "##[]",
	"returnPolicy": "##string",
	"minimumOrderQuantity": "##number",
	"meta": "##ignore",
	"thumbnail": "##string",
	"images": "##[]"
	}
	"""

