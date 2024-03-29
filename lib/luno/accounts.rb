module Luno
  module Accounts
    def list_accounts
      path = 'accounts'
      authorise_and_send(http_method: :get, path: path)
    end

    def list_pending_account_transactions(account_id)
      path = "accounts/#{account_id}/pending"
      authorise_and_send(http_method: :get, path: path)
    end

    # Path params: min_row=1&max_row=1000
    def list_account_transactions(account_id, min_row: -1000, max_row: 0)
      path = "accounts/#{account_id}/transactions"
      path_params = { min_row: min_row, max_row: max_row }
      authorise_and_send(http_method: :get, path: path, params: path_params)
    end

    # List balances has been moved and retired as an endpoint

    # POST paths
    # TODO:
    # Create account: /api/1/accounts body: { name: '', currency: '' }
    # TODO: Check internally that inputs are valid

    # PUT paths
    # TODO:
    # Update Account name:  /api/1/accounts/{id}/name body: { name: '' }
  end
end
