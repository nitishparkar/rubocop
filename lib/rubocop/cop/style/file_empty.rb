# frozen_string_literal: true

module RuboCop
  module Cop
    module Style
      # Checks for usages of `File.zero?` which can be replaced by `File.empty?`.
      # `File.empty?` reads better than its alias `File.zero?`
      #
      # @example
      #
      #   # bad
      #   File.zero?(file_name)
      #
      #   # good
      #   File.empty?(file_name)
      #
      class FileEmpty < Base
        extend AutoCorrector

        MSG = 'Use `File.empty?` instead of `File.zero?`.'

        RESTRICT_ON_SEND = %i[zero?].freeze

        # @!method file_zero_call?(node)
        def_node_matcher :file_zero_call?, <<~PATTERN
          (send (const nil? :File) :zero? ...)
        PATTERN

        def on_send(node)
          return unless file_zero_call?(node)

          add_offense(node) do |corrector|
            corrector.replace(node, node.source.sub('File.zero?', 'File.empty?'))
          end
        end
      end
    end
  end
end
