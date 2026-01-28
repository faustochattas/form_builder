# frozen_string_literal: true

module FormBuilder
  module Questions
    class BooleanQuestion < BaseQuestion
      def render(responses)
        value = responses[id]
        yes_checked = value == true ? "x" : " "
        no_checked = value == false ? "x" : " "

        <<~TXT.strip
          #{label}
             - (#{yes_checked}) Yes (value: true)
             - (#{no_checked}) No (value: false)
        TXT
      end
    end
  end
end