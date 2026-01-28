# frozen_string_literal: true

require_relative "../presets"

module FormBuilder
  module Questions
    class RadioQuestion < BaseQuestion
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
          checked = selected == opt[:value] || selected == opt["value"] ? "x" : " "
          lines << "  - (#{checked}) #{opt[:label] || opt['label']} (value: '#{opt[:value] || opt['value']}')"
        end

        lines.join("\n")
      end
    end
  end
end
