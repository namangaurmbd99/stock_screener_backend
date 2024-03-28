class StocksController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show, :create, :update, :destroy]

  # GET /stocks
  def index
    symbols = ['AAPL', 'MSFT', 'GOOGL'] # Example list of stock symbols to fetch data for
    api_key = LFWIVFK03XKNCJIJ # Your Alpha Vantage API key

    stocks_data = []

    symbols.each do |symbol|
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=#{symbol}&interval=5min&apikey=#{api_key}"
      
      response = HTTParty.get(url)
      data = JSON.parse(response.body)

      stocks_data << { symbol: symbol, data: data } if data.present?
    end
    
    render json: stocks_data
  end

  # Other controller actions (show, create, update, destroy) remain unchanged
end
