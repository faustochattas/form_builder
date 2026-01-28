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

      def render_body(responses)
        selected = responses[id]

        lines = []
        @options.each do |opt|
          value = opt[:value] || opt["value"]
          text = opt[:label] || opt["label"]
          checked = selected == value ? "x" : " "
          lines << "  - (#{checked}) #{text} (value: '#{value}')"
        end

        lines.join("\n")
      end
    end
  end
end