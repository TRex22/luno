module Luno
  module Accounts
    def list_accounts
      path = 'accounts'
      authorise_and_send(http_method: :get, path: path)
    end
  end
end