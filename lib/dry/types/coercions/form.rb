require 'bigdecimal'
require 'bigdecimal/util'

module Dry
  module Types
    module Coercions
      module Form
        TRUE_VALUES = %w[1 on  t true  y yes].freeze
        FALSE_VALUES = %w[0 off f false n no].freeze
        BOOLEAN_MAP = ::Hash[TRUE_VALUES.product([true]) + FALSE_VALUES.product([false])].freeze
        EMPTY_STRING = ''.freeze

        def self.to_nil(input)
          JSON.to_nil(input)
        end

        def self.to_date(input)
          JSON.to_date(input)
        end

        def self.to_date_time(input)
          JSON.to_date_time(input)
        end

        def self.to_time(input)
          JSON.to_time(input)
        end

        def self.to_true(input)
          BOOLEAN_MAP.fetch(input, input)
        end

        def self.to_false(input)
          BOOLEAN_MAP.fetch(input, input)
        end

        def self.to_int(input)
          return if empty_str?(input)

          result = input.to_i

          if result === 0 && !input.eql?('0')
            input
          else
            result
          end
        end

        def self.to_float(input)
          return if empty_str?(input)

          result = input.to_f

          if result.eql?(0.0) && (!input.eql?('0') && !input.eql?('0.0'))
            input
          else
            result
          end
        end

        def self.to_decimal(input)
          result = to_float(input)

          if result.is_a?(Float)
            result.to_d
          else
            result
          end
        end

        def self.empty_str?(value)
          EMPTY_STRING.eql?(value)
        end
        private_class_method :empty_str?
      end
    end
  end
end
