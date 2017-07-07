
require "#{Rails.root}/lib/aes_encryption/aes_module.rb"

# require "bittrex/version"
# require 'openssl'
# require 'json'
# require 'open-uri'
#
# module Bittrex
#   class << self
#     API_VERSION = 'v1.1'
#
#     def new_process(api_key, api_secret, trade_for = "BTC")
#       @api_key = api_key
#       @api_secret = api_secret
#       @trade_for = trade_for + "-"
#     end
#
#     def ticker(market)
#       request("https://bittrex.com/api/#{API_VERSION}/public/getticker", "market=#{@trade_for}#{market}")
#     end
#
#     def summaries
#       request("https://bittrex.com/api/#{API_VERSION}/public/getmarketsummaries")
#     end
#
#     def getmarketsummary
#       request("https://bittrex.com/api/#{API_VERSION}/public/getmarketsummary?market=BTC-LTC")
#     end
#
#     def orderbook(market, type, depth = 50)
#       request("https://bittrex.com/api/#{API_VERSION}/public/getorderbook", "market=#{@trade_for}#{market}&type=#{type}&depth=#{depth}")
#     end
#
#     def market_history(market, count = 10)
#       request("https://bittrex.com/api/v1.1/public/getmarkethistory", "market=#{@trade_for}#{market}&count=#{count}")
#     end
#
#
#     def buy(market, quantity, rate = nil)
#       if rate
#         request("https://bittrex.com/api/#{API_VERSION}/market/buylimit", "market=#{@trade_for}#{market}&quantity=#{quantity}&rate=#{rate}")
#       else
#         request("https://bittrex.com/api/#{API_VERSION}/market/buymarket", "market=#{@trade_for}#{market}&quantity=#{quantity}")
#       end
#     end
#
#     def sell(market, quantity, rate = nil)
#       if rate
#         request("https://bittrex.com/api/#{API_VERSION}/market/selllimit", "market=#{@trade_for}#{market}&quantity=#{quantity}&rate=#{rate}")
#       else
#         request("https://bittrex.com/api/#{API_VERSION}/market/sellmarket", "market=#{@trade_for}#{market}&quantity=#{quantity}")
#       end
#     end
#
#     def cancel(order_id)
#       request("https://bittrex.com/api/#{API_VERSION}/market/cancel", "uuid=#{order_id}")
#     end
#
#     def open_orders(market = '')
#       request("https://bittrex.com/api/#{API_VERSION}/market/getopenorders", "market=#{@trade_for}#{market}")
#     end
#
#     def balance(currency)
#       request("https://bittrex.com/api/#{API_VERSION}/account/getbalance", "currency=#{currency}")
#     end
#
#     def balance_all
#       request("https://bittrex.com/api/#{API_VERSION}/account/getbalances?apikey=#{@api_key}")
#     end
#
#     def order_history(market = nil, count = 5)
#       params = market ? "market=#{@trade_for}#{market}&count=#{count}" : "count=#{count}"
#       request("https://bittrex.com/api/#{API_VERSION}/account/getorderhistory", params)
#     end
#
#     private
#
#     def generate_sign(url, params)
#       nonce = Time.now.to_i
#       @final_url = "#{url}?apikey=#{@api_key}&nonce=#{nonce}&"+params
#       OpenSSL::HMAC.hexdigest(digest = OpenSSL::Digest.new('sha512'), @api_secret, @final_url)
#     end
#
#     def handle_response(req)
#       response = JSON.load(req)
#       if response['success']
#         response['result']
#       else
#         puts "Request failed: #{response}"
#         response['message']
#       end
#     end
#
#     def request(url, params = '')
#       begin
#         hmac_sign = generate_sign(url, params)
#         handle_response open(@final_url, 'apisign' => hmac_sign)
#       rescue
#         return false
#       end
#     end
#   end
# end
#
# class BittrexProcess
#
#   include Bittrex
#
#   def new(api_key, api_secret)
#     @api_key = api_key
#     @api_secret = api_secret
#   end
#
#   def create_bittrex_order
#     @api_key = "a36d5a84e9d949c3a923b138901ab5c9"
#     @api_secret = "4IMJMGBMEG5UCK74"
#
#     Bittrex.new_process(@api_key, @api_secret, "BTC")
#
#     Bittrex.balance_all
#     Bittrex.buy("LTC", 1.2, 1.3)
#     Bittrex.market_history("LTC", 10)
#     Bittrex.getmarketsummary
#   end
#
# end

class OrdersController < ApplicationController

  def index

    if !logged_in?
      redirect_to login_path
    end

    if !@current_user.verified?
      redirect_to @current_user
    end

    @orders = @current_user.orders

  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    # create_bittrex
    @order = Order.new
  end

  def create
    @orders = current_user.orders
    @order = Order.new(order_params)
    if @order.save
      tmp = true
      if tmp.present?

      end
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
     @orders = current_user.orders
     @order = Order.find(params[:id])
     if @order.try(:update_attributes, order_params)
       flash[:success] = "Updated successfully!"
     end
  end

  def delete
    @order = Order.find(params[:selected_order])
  end

  def destroy
    @orders = current_user.orders
    @order = Order.find(params[:id])
    @Order.destroy
    if @order.try(:destroy )
      flash[:success] = "Selected order successfully deleted!"
    end
    @orders = current_user.orders
  end

  def create_kraken
    # API_KEY = 'DPlHo0jK9gmGjB3w+YygCEFgbxAL7gTKfvlkUNgwKmUra7UcR/XScH4F'
    # API_SECRET = 'wfPQMISNpisdsBrE0ku0Wn7lykeTabpT0vuBFxPZnee0iTcxH5gMrYAlrXHIxgSFw78MwFZ/pJNBpR4D47eA9g=='
    #
    # @client = KrakenClient.load({ api_key: 'DPlHo0jK9gmGjB3w+YygCEFgbxAL7gTKfvlkUNgwKmUra7UcR/XScH4F',
    #                              api_secret: 'wfPQMISNpisdsBrE0ku0Wn7lykeTabpT0vuBFxPZnee0iTcxH5gMrYAlrXHIxgSFw78MwFZ/pJNBpR4D47eA9g==',
    #                                base_uri: 'https://api.kraken.com', tier: 1})
    # @opts = {
    #     pair: 'XBTXRP',
    #     type: 'buy',
    #     ordertype: 'market',
    #     volume: 0.01
    # }
    # @client.private.add_order(@opts)

  end

  def create_bittrex
    # bittrex1 = BittrexProcess.new
    # bittrex1.create_bittrex_order
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :order_name, :api_key, :api_secret_key, :exchange_type,
                                  :frequency_type, :invest_type, :amount)
  end
end

