require_relative 'spec_helper'
require_relative 'builder'

Rspec.describe 'Mokapay' do
  before :all do
    Moka.configure do |config|
      config.env = 'test'
      config.dealer_code = '1730'
      config.username = 'TestMoka1'
      config.password = 'YHSUSHDYHUDHD'
    end
  end

  it 'should create customer' do

  end
end