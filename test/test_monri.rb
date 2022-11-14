# frozen_string_literal: true

require 'minitest/autorun'
require 'monri'
require 'pry'
require 'securerandom'

class MonriTest < Minitest::Test
  def test_create

    Monri.environment = :test
    Monri.api_key = 'qwert1234'
    Monri.api_account = '7db11ea5d4a1af32421b564c79b946d1ead3daf0'

    request = {
      "transaction_type": 'authorize',
      "amount": 1000,
      "ip": '10.1.1.1',
      "order_info": 'RubySDK Example',
      "ch_address": 'Address',
      "ch_city": 'City',
      "ch_country": 'BIH',
      "ch_email": 'mit-test@monri.com',
      "ch_full_name": 'Monri',
      "ch_phone": '061 000 000',
      "ch_zip": '71000',
      "currency": 'EUR',
      "order_number": SecureRandom.hex,
      "language": 'en',
      "pan": '4111111111111111',
      "cvv": '123',
      "expiration_date": '3112'
    }
    response = Monri::Transaction.create(request)
    binding.pry
  end
end
