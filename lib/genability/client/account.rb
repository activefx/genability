module Genability
  class Client

    module Account

      def add_account(options = {})
        post("beta/accounts?appId=#{application_id}&appKey=#{application_key}", account_params(options)).results.first
      end

      def delete_account(account_id)
        delete("beta/accounts/#{account_id}")
      end

      def account(account_id)
        get("beta/accounts/#{account_id}").results.first
      end

      def accounts(options = {})
        get("beta/accounts", accounts_params(options)).results
      end

      private

      def account_params(options)
        {
          "accountName" => options[:account_name],
          "customerOrgId" => options[:customer_org_id],
          "providerAccountId" => options[:provider_account_id],
          "customerOrgName" => options[:customer_org_name]
        }.
        delete_if{ |k,v| v.nil? }.
        to_json
      end

      def accounts_params(options)
        pagination_params(options).
        merge( search_params(options) )
      end

    end
  end
end

