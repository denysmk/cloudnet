module PaygHelper
  def payg_options(account)
    @account = account
    @amounts = Payg::VALID_TOP_UP_AMOUNTS
    balance_option = add_option_to_pay_off_balance
    options = @amounts.map { |amount| ["$#{amount} USD", amount] }
    options[0][0] = "#{options[0][0]} (Outstanding balance)" if balance_option
    options_for_select options, @amounts.first
  end

  def add_option_to_pay_off_balance
    remaining_balance = (Invoice.milli_to_cents @account.remaining_balance) / 100.0
    return false unless remaining_balance > 0
    remaining_balance = format '%.2f', remaining_balance
    @amounts.unshift remaining_balance
  end
end
