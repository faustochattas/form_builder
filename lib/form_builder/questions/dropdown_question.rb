# frozen_string_literal: true

require_relative "../presets"

module FormBuilder
  module Questions
    class DropdownQuestion < BaseQuestion
      def initialize(config)
        super
        @options =
          if config["preset"]
            Presets.resolve(config["preset"])
          else
            config["options"] || []
          end
      end

      def render(responses)
        selected = responses[id]

        lines = [label]
        @options.each do |opt|
          value = opt[:value] || opt["value"]
          text  = opt[:label] || opt["label"]
          box = (selected == value) ? "<>" : "< >"
          lines << "  - #{box} #{text} (value: '#{value}')"
        end

        lines.join("\n")
      end
    end
  end
end
