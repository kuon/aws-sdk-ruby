module Aws
  module Plugins
    class ResponsePaging < Seahorse::Client::Plugin

      # @api private
      class Handler < Seahorse::Client::Handler

        def call(context)
          paging_provider = context.client.class::PAGING_PROVIDER
          pager = paging_provider.pager(context.operation.name)
          PageableResponse.new(@handler.call(context), pager)
        end

      end

      handler(Handler)

    end
  end
end