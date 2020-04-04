module ApplicationHelper
  def create_index params_page, index, per_page
    params_page = 1 if params_page.nil?
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end

  def format_money_amount money_amount
    number_to_currency money_amount,
      separator: currency_settings.separator,
      delimiter: currency_settings.delimiter,
      unit: currency_settings.unit,
      precision: currency_settings.precision
  end

  def current_quantity
    total = 0
    if session[:carts]
      session[:carts].each do |item|
        total += item["quantity"]
      end
    end
    total
  end

  def shopping_cart
    @carts = []

    if session[:carts]
      session[:carts].each do |item|
        @carts << OrderDetail.new(item)
      end
    end
    @carts
  end

  def total_price
    session[:carts].map {|item| item["quantity"]*item["money"]}.sum
  end

  private

  def currency_settings
    @currency_settings = Settings.currency
  end
end
