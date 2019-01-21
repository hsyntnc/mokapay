# Mokapay

Unofficial API wrapper for [MOKA](https://www.moka.com/) Payment System.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mokapay', require: 'moka'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mokapay

## Usage
```ruby
require 'moka'

Moka.configure do |config|
  config.dealer_code  = '1730'
  config.username     = 'TestMoka1'
  config.password     = 'YHSUSHDYHUDHD'
  config.env          = 'test' # Default production 
end
```
Note: When making any request, you can use all parameters on the official [documentation](https://developer.moka.com/home.php?page=3dsiz-odeme) with snake case.
For example you can use card_holder_full_name for CardHolderFullName on official documentation.


#### Create Direct Payment
```ruby
payment = Moka::Payment.new({
  card_holder_full_name: 'Huseyin TUNC',
  card_number: '5269552233334444',
  exp_month: '12',
  exp_year: '2022',
  cvc_number: '000',
  amount: 10.10,
  client_ip: '1.2.3.4',
  other_trx_code: 1
})

payment.pay # Make request (also returns the response)
payment.success? # To check if it success
payment.response # Returns the response 
```

#### Create 3D Payment
```ruby
payment = Moka::Payment.new({
  card_holder_full_name: 'Huseyin TUNC',
  card_number: '5269552233334444',
  exp_month: '12',
  exp_year: '2022',
  cvc_number: '000',
  amount: 10.10,
  client_ip: '1.2.3.4',
  other_trx_code: 1,
  redirect_url: 'http://localhost:3000/payments/success'
})

payment.pay_three_d
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hsyntnc/mokapay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
