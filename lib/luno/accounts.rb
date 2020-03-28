module Luno
  module Accounts
    # GET paths
    def list_accounts
      path = 'accounts'
      authorise_and_send(http_method: :get, path: path)
    end

    def list_account_transactions(account_id)
      path = "accounts/#{account_id}/transactions"
      authorise_and_send(http_method: :get, path: path)
    end

    # POST paths

    # PUT paths
  end
end