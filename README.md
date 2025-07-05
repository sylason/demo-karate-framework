# API Testing Demo with Karate Framework

This is a demo project created to learn and demonstrate the capabilities of **Karate Framework** in automated API testing. This project uses the public API from [DummyJSON](https://dummyjson.com/) to implement test scenarios for a simulated e-commerce system.

## Tested features
This project includes test suites for the following core API functions:

* **Product Management (`/products`)**

* `GET /products`: Get a list of products and thoroughly test the data structure.

* `GET /products/{id}`: Get a product's details and test nested fields.
* `POST /products/add`: Create a new product (including success and error scenarios).

* `PUT /products/{id}`: Update a product.

* `DELETE /products/{id}`: Delete a product and verify the deletion action.


## Test Run Instructions

### Environment Requirements
* Java Development Kit (JDK) version 11 or higher.
* Conflicted version with JDK higher than 22
* Apache Maven installed and configured in the environment variable.

### Steps to follow
1. **Clone this repository to your machine:**
```bash
git clone https://github.com/sylason/demo-karate-framework/.git
```

2. **Move into the project directory:**
```bash
cd demo-karate-framework
```

3. **Run the test using Maven:**
This command will automatically download the necessary libraries, compile and run all the test scripts (`.feature` files).
```bash
mvn test
```
After running, a detailed report will be generated in the `target/karate-reports` directory.

## View the Test Report

**[=> Click here to see the Live Test Report]([https://github.com/sylason/demo-karate-framework/target/karate-reports/karate-summary.html)**

---
