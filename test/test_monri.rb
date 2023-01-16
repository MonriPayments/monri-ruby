# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'monri'
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
    assert_equal 'approved', rv.status
    assert rv.access_token != nil
    assert rv.token_type != nil
    assert rv.expires_in != nil
  end

  def test_create_customer
    rv = monri.customers.create(email: 'email@email.com', name: 'name')
    assert !rv.failed?
    assert_equal 'approved', rv.status
    assert_equal 'email@email.com', rv.email
    assert_equal 'name', rv.name
    assert rv.uuid != nil
    assert rv.created_at != nil
    assert rv.updated_at != nil
  end

  def test_payment_methods_list
    rv = monri.payment_methods.list
    assert_equal 'approved', rv[:status]
    assert rv[:data].is_a?(Array)
  end

  def test_payment_create
    response = monri.payments.create(
      order_number: SecureRandom.hex,
      amount: 10_00,
      currency: 'EUR',
      transaction_type: 'purchase'
    )

    assert !response.failed?
    assert response.is_a?(Monri::Payments::CreateResponse)
    assert response.approved?
    assert_equal 'approved', response.status
    assert response.id.is_a?(String)
    assert response.client_secret.is_a?(String)
    assert response.id != nil
    assert response.client_secret != nil
  end

  def test_payment_status
    response = monri.payments.create(
      order_number: SecureRandom.hex,
      amount: 10_00,
      currency: 'EUR',
      transaction_type: 'purchase'
    )
    assert !response.failed?
    assert response.is_a?(Monri::Payments::CreateResponse)
    assert response.approved?

    response = monri.payments.status(response.id)
    assert !response.failed?
    assert response.is_a?(Monri::Payments::StatusResponse)
    assert response.status == 'approved'
    assert response.payment_status == 'payment_method_required'
  end

  def test_temp_tokenize_and_authorize
    token = monri.tokens.create_ephemeral_card_token(cvv: '111', pan: '4111111111111111', expiration_date: '2912', type: 'card')
    assert !token.failed?
    assert token.is_a?(Monri::Tokens::EphemeralCardTokenResponse)
    assert token.approved?
    assert token.id != nil
    assert token.status != nil
    assert token.masked_pan != nil
    assert token.cc_type != nil
    assert token.cc_issuer != nil

    id = token.id

    rv = monri.transactions.transaction(
      amount: 200,
      currency: 'EUR',
      transaction_type: 'purchase',
      order_number: SecureRandom.hex,
      order_info: "Info #{SecureRandom.hex}",
      ch_address: 'Address',
      ch_city: 'Sarajevo',
      ch_country: 'BA',
      ch_email: 'test@monri.com',
      ch_full_name: 'Test Test',
      ch_phone: '+38761000111',
      ch_zip: '71000',
      language: 'en',
      ip: '127.0.0.1',
      temp_card_id: id
    )
    assert !rv.failed?

    assert rv.is_a?(Monri::Transactions::TransactionResponse)
    assert rv.transaction != nil
    assert rv.secure_message == nil
    assert rv.exception == nil
    assert rv.transaction.is_a?(Monri::Transactions::Transaction)
    assert rv.transaction.id != nil
  end

  def test_transactions_invalid_request

    rv = monri.transactions.transaction(
      amount: 200,
      currency: 'EUR',
      transaction_type: 'purchase',
      order_number: SecureRandom.hex,
      order_info: "Info #{SecureRandom.hex}",
      ch_address: 'Address',
      ch_city: 'Sarajevo',
      ch_country: 'BA',
      ch_email: 'test@monri.com',
      ch_full_name: 'Test Test',
      ch_phone: '+38761000111',
      ch_zip: '71000',
      language: 'en',
      ip: '127.0.0.1'
      )
    assert rv.failed?
    assert rv.errors.is_a?(Array)
    assert rv.errors.any? {|x| x == "Pan can't be blank"}
    assert rv.exception != nil

    assert rv.is_a?(Monri::Transactions::TransactionResponse)
    assert rv.transaction == nil
    assert rv.secure_message == nil
  end

  def test_temp_tokenize_and_authorize_three_ds
    token = monri.tokens.create_ephemeral_card_token(
      cvv: '111',
      pan: '4341 7920 0000 0044',
      expiration_date: '3012',
      type: 'card'
    )
    assert !token.failed?
    assert token.is_a?(Monri::Tokens::EphemeralCardTokenResponse)
    assert token.approved?
    assert token.id != nil
    assert token.status != nil
    assert token.masked_pan != nil
    assert token.cc_type != nil
    assert token.cc_issuer != nil
    id = token.id

    rv = monri.transactions.transaction(
      amount: 200,
      currency: 'EUR',
      transaction_type: 'purchase',
      order_number: SecureRandom.hex,
      order_info: "Info #{SecureRandom.hex}",
      ch_address: 'Address',
      ch_city: 'Sarajevo',
      ch_country: 'BA',
      ch_email: 'test@monri.com',
      ch_full_name: 'Test Test',
      ch_phone: '+38761000111',
      ch_zip: '71000',
      language: 'en',
      ip: '127.0.0.1',
      temp_card_id: id
    )
    assert !rv.failed?

    assert rv.is_a?(Monri::Transactions::TransactionResponse)
    assert rv.transaction == nil
    assert rv.secure_message != nil
    assert rv.exception == nil
    assert rv.secure_message.is_a?(Monri::Transactions::SecureMessage)
    assert rv.secure_message.id != nil
    assert rv.secure_message.acs_url != nil
    assert rv.secure_message.authenticity_token != nil
  end

end
