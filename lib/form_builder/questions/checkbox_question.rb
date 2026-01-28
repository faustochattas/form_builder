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

      def render_body(responses)
        selected = Array(responses[id])

        lines = []

        @options.each do |opt|
          value = opt[:value] || opt["value"]
          text = opt[:label] || opt["label"]
          checked = selected.include?(value) ? "x" : " "
          lines << "  - [#{checked}] #{text} (value: '#{value}')"
        end

        if @allow_other
          other_selected = selected.include?("_")
          checked = other_selected ? "x" : " "
          lines << "  - [#{checked}] Other (value: '_')"

          if other_selected
            other_text_key = "#{id}_other"
            other_text = responses[other_text_key]
            if other_text && !other_text.to_s.strip.empty?
              lines << "    Other text: #{other_text.inspect}"
            end
          end
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