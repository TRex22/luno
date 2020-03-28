module Luno
  module Beneficiaries
    def list_beneficiaries
      path = 'beneficiaries'
      authorise_and_send(http_method: :get, path: path)
    end
  end
end