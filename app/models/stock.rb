class Stock < ApplicationRecord
	has_many :user_stocks
	has_many :users, through: :user_stocks 

	validates :name, :ticker, presence: true

	def self.new_lookup(ticker_symbol)
		client = IEX::Api::Client.new(
		  publishable_token: 'Tpk_5dd481d6b02a4a7a943d9d02c2893c80',
		  secret_token: 'Tsk_4761d91893ac4f549f260da040a4712f',
		  endpoint: 'https://sandbox.iexapis.com/v1'
		)

		begin
			new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
		rescue => exception
			return nil
			
		end
	end

	def self.check_db(ticker_symbol)
		where(ticker:"ticker_symbol").first
	end

end

