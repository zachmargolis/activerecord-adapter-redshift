# frozen_string_literal: true

module ActiveRecord
  module ConnectionAdapters
    module Redshift
      module OID # :nodoc:
        class Json < Type::Value # :nodoc:
          include ActiveModel::Type::Helpers::Mutable

          def type
            :json
          end

          def type_cast_from_database(value)
            if value.is_a?(::String)
              begin
                ::ActiveSupport::JSON.decode(value)
              rescue StandardError
                nil
              end
            else
              super
            end
          end

          def type_cast_for_database(value)
            if value.is_a?(::Array) || value.is_a?(::Hash)
              ::ActiveSupport::JSON.encode(value)
            else
              super
            end
          end

          def accessor
            ActiveRecord::Store::StringKeyedHashAccessor
          end
        end
      end
    end
  end
end
