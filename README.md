# Monri API Library for Ruby

This is the officially supported Ruby library for using Monri's APIs.

## Integration
The library supports all APIs under the following services:

* [Payments API](https://docs.monri.com/documentation/api-documentation/api-v2/payment-api): Payments integration
* [Customers API](https://docs.monri.com/documentation/api-documentation/api-v2/customers-api): Customers integration
* [Payment Methods API](https://docs.monri.com/documentation/api-documentation/api-v2/payment-method-api): Payment methods integration

For more information, refer to our [documentation](https://docs.monri.com/)

## Prerequisites
- Monri test account
- Merchant key + authenticity token
- Ruby >= 2.2

## Installation

The sole dependency is faraday for HTTP communication. Run the following command to install faraday if you don't already have it:

````bash 
bundle install
````

To validate functionality of client and run mock API tests use

````bash  
bundle install --with development 
````
and
````bash 
rspec
````
## Documentation

Follow the rest of our guides from the [documentation](https://docs.monri.com/) on how to use this library.

## Using the library

### General use with API key

````bash 
require 'monri-ruby-api-library'
````
````ruby
monri = Monri::Client.new

monri.api_key = 'AF5XXXXXXXXXXXXXXXXXXXX'

````

- Create a Payment
````ruby
response = monri.payments.create(
  order_number: SecureRandom.hex,
  amount: 10_00,
  currency: 'EUR',
  transaction_type: 'purchase'
)
# check if request failed
assert !response.failed?
# Get payment id
puts response.id
````

### Example integration

For a closer look at how our Ruby library works, clone our [example integration](https://github.com/MonriPayments/monri-ruby-example)

### Running the tests
To run the tests use :
````bash  
bundle install --with development 
````



## Support
If you have a feature request, or spotted a bug or a technical problem, [create an issue here](https://github.com/MonriPayments/monri-ruby/issues/new/choose).

For other questions, [contact our Support Team](https://www.monri.com).

## Licence
This repository is available under the [MIT license](https://github.com/MonriPayments/monri-ruby/blob/master/LICENSE).

## See also
* [Example integration](https://github.com/MonriPayments/monri-ruby-example)
* [Monri docs](https://docs.monri.com/)