# frozen_string_literal: true

require 'minitest/autorun'
require 'monri'
require 'pry'
require 'securerandom'

class MonriTest < Minitest::Test

  attr_reader :monri

  def before_setup
    @monri = Monri::Client.new
    @monri.merchant_key = 'qwert1234'
    @monri.authenticity_token = '7db11ea5d4a1af32421b564c79b946d1ead3daf0'
    @monri.environment = 'test'
  end

  def test_access_tokens_create
    rv = monri.access_tokens.create(scopes: ['customers'])
    assert_equal 'approved', rv[:status]
    assert !rv[:access_token].nil?
    assert !rv[:token_type].nil?
    assert !rv[:expires_in].nil?
  end

  def test_create_customer
    rv = monri.customers.create(email: 'email@email.com', name: 'name')
    assert_equal 'approved', rv[:status]
    assert_equal 'email@email.com', rv[:email]
    assert_equal 'name', rv[:name]
    assert rv[:uuid] != nil
    assert rv[:created_at] != nil
    assert rv[:updated_at] != nil
  end

  def test_payment_methods_list
    rv = monri.payment_methods.list
    assert_equal 'approved', rv[:status]
    assert rv[:data].is_a?(Array)
  end

  def test_payment_create
    # "Order number can't be blank,Amount can't be blank,Amount is not a number,Currency can't be blank,Transaction type can't be blank"
    response = monri.payments.create(order_number: SecureRandom.hex, amount: 10_00, currency: 'EUR', transaction_type: 'purchase')
    result = response.result
    assert response.success?
    assert_equal 'approved', result[:status]
    assert result[:id].is_a?(String)
    assert result[:client_secret].is_a?(String)
    assert result[:id] != nil
    assert result[:client_secret] != nil
  end
end
