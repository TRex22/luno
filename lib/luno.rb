require 'httparty'

require 'luno/version'

# Endpoints
require 'luno/accounts'
require 'luno/beneficiaries'
require 'luno/markets'
require 'luno/orders'
require 'luno/quotes'
require 'luno/receiving'
require 'luno/sending'
require 'luno/transactions'
require 'luno/withdrawals'

# Beta Endpoints
require 'luno/lightning'
require 'luno/streaming'

# Custom Endpoints
require 'luno/other_data'

require 'luno/client'

module Luno
  class Error < StandardError; end
end
