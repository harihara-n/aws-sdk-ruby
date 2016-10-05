# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing for info on making contributions:
# https://github.com/aws/aws-sdk-ruby/blob/master/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws
  module EC2
    class Tag

      extend Aws::Deprecations

      # @overload def initialize(resource_id, key, value, options = {})
      #   @param [String] resource_id
      #   @param [String] key
      #   @param [String] value
      #   @option options [Client] :client
      # @overload def initialize(options = {})
      #   @option options [required, String] :resource_id
      #   @option options [required, String] :key
      #   @option options [required, String] :value
      #   @option options [Client] :client
      def initialize(*args)
        options = Hash === args.last ? args.pop.dup : {}
        @resource_id = extract_resource_id(args, options)
        @key = extract_key(args, options)
        @value = extract_value(args, options)
        @data = options.delete(:data)
        @client = options.delete(:client) || Client.new(options)
      end

      # @!group Read-Only Attributes

      # @return [String]
      def resource_id
        @resource_id
      end

      # @return [String]
      def key
        @key
      end

      # @return [String]
      def value
        @value
      end

      # The resource type.
      # @return [String]
      def resource_type
        data.resource_type
      end

      # @!endgroup

      # @return [Client]
      def client
        @client
      end

      # Loads, or reloads {#data} for the current {Tag}.
      # Returns `self` making it possible to chain methods.
      #
      #     tag.reload.data
      #
      # @return [self]
      def load
        resp = @client.describe_tags(filters: [
          {
            name: "key",
            values: [@key]
          },
          {
            name: "value",
            values: [@value]
          }
        ])
        @data = resp.tags[0]
        self
      end
      alias :reload :load

      # @return [Types::TagDescription]
      #   Returns the data for this {Tag}. Calls
      #   {Client#describe_tags} if {#data_loaded?} is `false`.
      def data
        load unless @data
        @data
      end

      # @return [Boolean]
      #   Returns `true` if this resource is loaded.  Accessing attributes or
      #   {#data} on an unloaded resource will trigger a call to {#load}.
      def data_loaded?
        !!@data
      end

      # @!group Actions

      # @example Request syntax with placeholder values
      #
      #   tag.delete({
      #     dry_run: false,
      #     tags: [
      #       {
      #         key: "String",
      #         value: "String",
      #       },
      #     ],
      #   })
      # @param [Hash] options ({})
      # @option options [Boolean] :dry_run
      #   Checks whether you have the required permissions for the action,
      #   without actually making the request, and provides an error response.
      #   If you have the required permissions, the error response is
      #   `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
      # @option options [Array<Types::Tag>] :tags
      #   One or more tags to delete. If you omit the `value` parameter, we
      #   delete the tag regardless of its value. If you specify this parameter
      #   with an empty string as the value, we delete the key only if its value
      #   is an empty string.
      # @return [EmptyStructure]
      def delete(options = {})
        options = Aws::Util.deep_merge(options,
          resources: [@resource_id],
          tags: [{
            key: @key,
            value: @value
          }]
        )
        resp = @client.delete_tags(options)
        resp.data
      end

      # @deprecated
      # @api private
      def identifiers
        {
          resource_id: @resource_id,
          key: @key,
          value: @value
        }
      end
      deprecated(:identifiers)

      private

      def extract_resource_id(args, options)
        value = args[0] || options.delete(:resource_id)
        case value
        when String then value
        when nil then raise ArgumentError, "missing required option :resource_id"
        else
          msg = "expected :resource_id to be a String, got #{value.class}"
          raise ArgumentError, msg
        end
      end

      def extract_key(args, options)
        value = args[1] || options.delete(:key)
        case value
        when String then value
        when nil then raise ArgumentError, "missing required option :key"
        else
          msg = "expected :key to be a String, got #{value.class}"
          raise ArgumentError, msg
        end
      end

      def extract_value(args, options)
        value = args[2] || options.delete(:value)
        case value
        when String then value
        when nil then raise ArgumentError, "missing required option :value"
        else
          msg = "expected :value to be a String, got #{value.class}"
          raise ArgumentError, msg
        end
      end

      class Collection

        include Aws::Resources::Collection

        # @return [Enumerator<Tag>]
        def each(&block)
          enum = super
          enum.each(&block) if block
          enum
        end

        # @!group Batch Actions

        # @param options ({})
        # @return [void]
        def batch_delete!(options = {})
        end

        # @!endgroup

      end
    end
  end
end
