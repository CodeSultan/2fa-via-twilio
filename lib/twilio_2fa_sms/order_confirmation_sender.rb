

module OrderConfirmationSender
  def self.send_confirmation_to(user, order)
    verification_code = generate
    order.update(verification_code: verification_code)
    send_code(user.countryCode + user.phoneNumber, verification_code)
  end

  def self.generate
    rand(100000...999999).to_s
  end

  def self.send_code(phone_number, code)
    # account_sid = ENV['TWILIO_ACCOUNT_SID']
    # auth_token  = ENV['TWILIO_AUTH_TOKEN']

    account_sid = 'AC447136212b087a81ec5794281d703b9a'
    auth_token = 'a749bfc95049606e204f53b75bea7622'

    client = Twilio::REST::Client.new(account_sid, auth_token)

    message = client.messages.create(
        # from:  ENV['TWILIO_NUMBER'],
        from: '+18565215872',
        to:    phone_number,
        body:  code
    )
    message.status == 'queued'
  end
end