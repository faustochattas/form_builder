# frozen_string_literal: true

require_relative "../presets"

module FormBuilder
  module Questions
    class CheckboxQuestion < BaseQuestion
      def initialize(config)
        super
        @options =
          if config["preset"]
            Presets.resolve(config["preset"])
          else
            config["options"] || []
          end

        @allow_other = config["allow_other"]
        @allow_none = config["allow_none"]
      end

      def render(responses)
        selected = Array(responses[id])

        lines = [label]

        @options.each do |opt|
          value = opt[:value] || opt["value"]
          label = opt[:label] || opt["label"]
          checked = selected.include?(value) ? "x" : " "
          lines << "  - [#{checked}] #{label} (value: '#{value}')"
        end

        if @allow_other
          checked = selected.include?("_") ? "x" : " "
          lines << "  - [#{checked}] Other (value: '_')"
        end

        if @allow_none
          checked = selected.include?("none_of_the_above") ? "x" : " "
          lines << "  - [#{checked}] None of the above (value: 'none_of_the_above')"
        end

        lines.join("\n")
      end
    end
  end
end
