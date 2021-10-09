module Luno
  module Constants
    CURRENCIES = {
      XBT: 'Bitcoin',
      BCH: 'Bitcoin Cash',
      ETH: 'Ethereum',
      EUR: 'Euro',
      MYR: 'Malaysian Ringgit',
      NGN: 'Nigerian Naira',
      UGX: 'Ugandan Shilling',
      ZAR: 'South African Rand',
      ZMW: 'Zambian Kwacha'
    }

    # TODO: Update, see: https://www.luno.com/en/countries
    CURRENCY_PAIRS = [
      'XBTEUR',
      'XBTZAR',
      'XBTUGX',
      'XBTZMW',
      'ETHXBT',
      'BCHXBT'
    ]

    WITHDRAWL_CURRENCIES = [
      BTC: 'Bitcoin',
      BCH: 'Bitcoin Cash',
      ETH: 'Ethereum',
      BTC_LN: 'Lightning'
    ]

    WITHDRAWL_CURRENCY_PAIR_METHODS = {
      ZAR_EFT: 'EFT',
      NAD_EFT: 'EFT',
      KES_EFT: 'EFT',
      KES_MPESA: 'M-Pesa',
      MYR_IBG: 'Interbank GIRO / IBFT',
      IDR_LLG: 'Bank transfer, Lalu Lintas Giro',
      NGN_EFT: 'Bank transfer',
      ZMW_EFT: 'Bank transfer',
      SGD_GIRO: 'GIRO / FAST',
      SGD_WIRE: 'International Wire',
      EUR_SEPA: 'SEPA transfer',
      UGX_EFT: 'Bank transfer',
    }

    PERMISSIONS = {
      Perm_R_Balance: { id: 1, description: '(View balance)' },
      Perm_R_Transactions: { id: 2, description: '(View transactions)' },
      Perm_W_Send: { id: 4, description: '(Send to any address)' },
      Perm_R_Addresses: { id: 8, description: '(View addresses)' },
      Perm_W_Addresses: { id: 16, description: '(Create addresses)' },
      Perm_R_Orders: { id: 32, description: '(View orders)' },
      Perm_W_Orders: { id: 64, description: '(Create orders)' },
      Perm_R_Withdrawals: { id: 128, description: '(View withdrawals)' },
      Perm_W_Withdrawals: { id: 256, description: '(Create withdrawals)' },
      Perm_R_Merchant: { id: 512, description: '(View merchant invoices)' },
      Perm_W_Merchant: { id: 1024, description: '(Create merchant invoices)' },
      Perm_W_ClientDebit: { id: 8192, description: '(Debit accounts)' },
      Perm_W_ClientCredit: { id: 16384, description: '(Credit accounts)' },
      Perm_R_Beneficiaries: { id: 32768, description: '(View beneficiaries)' },
      Perm_W_Beneficiaries: { id: 65536, description: '(Create and delete beneficiaries)' },
    }

    MARKET_API_RATE_LIMIT = 1 # per second per ip
    MARKET_API_BURST_RATE_LIMIT = 5 # per second per ip

    API_RATE_LIMIT = 5 # per second per ip
    API_BURST_RATE_LIMIT = 25 # per second per ip
  end
end
