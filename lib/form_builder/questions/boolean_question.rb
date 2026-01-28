# frozen_string_literal: true

module FormBuilder
  module Questions
    class BooleanQuestion < BaseQuestion
      def render(responses)
        value = responses[id]
        yes_checked = value == true ? "x" : " "
        no_checked = value == false ? "x" : " "

        lines = []
        lines << label
        lines << "   - (#{yes_checked}) Yes (value: true)"
        lines << "   - (#{no_checked}) No (value: false)"
        lines.join("\n")
      end
    end
  end
end