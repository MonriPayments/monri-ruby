# frozen_string_literal: true

require 'minitest/autorun'
require 'monri'
require 'pry'
require 'securerandom'

class MonriTest < Minitest::Test

  def test_access_tokens_create
    monri = Monri::Client.new
    monri.merchant_key = 'qwert1234'
    monri.authenticity_token = '7db11ea5d4a1af32421b564c79b946d1ead3daf0'
    monri.environment = 'test'
    rv = monri.access_tokens.create(scopes: ['customers'])
    assert_equal 'approved', rv[:status]
    assert !rv[:access_token].nil?
    assert !rv[:token_type].nil?
    assert !rv[:expires_in].nil?
  end

  def test_create_customer
    monri = Monri::Client.new
    monri.merchant_key = 'qwert1234'
    monri.authenticity_token = '7db11ea5d4a1af32421b564c79b946d1ead3daf0'
    monri.environment = 'test'
    rv = monri.customers.create(email: 'email@email.com', name: 'name')
    assert_equal 'approved', rv[:status]
    assert_equal 'email@email.com', rv[:email]
    assert_equal 'name', rv[:name]
    assert rv[:uuid] != nil
    assert rv[:created_at] != nil
    assert rv[:updated_at] != nil
  end

  def test_payment_methods_list
    monri = Monri::Client.new
    monri.merchant_key = 'qwert1234'
    monri.authenticity_token = '7db11ea5d4a1af32421b564c79b946d1ead3daf0'
    monri.environment = 'test'
    rv = monri.payment_methods.list
    assert_equal 'approved', rv[:status]
    assert rv[:data].is_a?(Array)
  end
end
