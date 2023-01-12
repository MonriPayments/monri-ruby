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

~~~~bash 
bundle install
~~~~

To validate functionality of client and run mock API tests use

~~~~bash  
bundle install --with development 
~~~~
and
~~~~bash 
rspec
~~~~
## Documentation

Follow the rest of our guides from the [documentation](https://monri.github.io/monri-ruby-api-library/) on how to use this library.

## Using the library

### General use with API key

~~~~bash 
require 'monri-ruby-api-library'
~~~~
~~~~ruby
monri = Monri::Client.new

monri.api_key = 'AF5XXXXXXXXXXXXXXXXXXXX'

~~~~

- Make a Payment
~~~~ruby
response = monri.checkout.payments({
  :amount => {
    :currency => "EUR",
    :value => 1000
  },
  :reference => "Your order number",
  :paymentMethod => {
    :type => "scheme",
    :encryptedCardNumber => "test_4111111111111111",
    :encryptedExpiryMonth => "test_03",
    :encryptedExpiryYear => "test_2030",
    :encryptedSecurityCode => "test_737"
  },
  :returnUrl => "https://your-company.com/checkout/",
  :merchantAccount => "YourMerchantAccount"
})
~~~~

- Change API Version
~~~~ruby
monri.checkout.version = 68
~~~~

### Example integration

For a closer look at how our Ruby library works, clone our [example integration](https://github.com/monri-examples/monri-rails-online-payments). This includes commented code, highlighting key features and concepts, and examples of API calls that can be made using the library.

### Running the tests
To run the tests use :
~~~~bash  
bundle install --with development 
~~~~

## Contributing

We encourage you to contribute to this repository, so everyone can benefit from new features, bug fixes, and any other improvements.
Have a look at our [contributing guidelines](https://github.com/Monri/monri-ruby-api-library/blob/develop/CONTRIBUTING.md) to find out how to raise a pull request.

## Support
If you have a feature request, or spotted a bug or a technical problem, [create an issue here](https://github.com/Monri/monri-ruby-api-library/issues/new/choose).

For other questions, [contact our Support Team](https://www.monri.help/hc/en-us/requests/new?ticket_form_id=360000705420).

## Licence
This repository is available under the [MIT license](https://github.com/Monri/monri-ruby-api-library/blob/main/LICENSE).

## See also
* [Example integration](https://github.com/monri-examples/monri-rails-online-payments)
* [Monri docs](https://docs.monri.com/)
* [API Explorer](https://docs.monri.com/api-explorer/)