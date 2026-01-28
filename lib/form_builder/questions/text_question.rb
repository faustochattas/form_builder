# frozen_string_literal: true

module FormBuilder
  module Questions
    class TextQuestion < BaseQuestion
      def initialize(config)
        super
        @min = config["min_length"]
        @max = config["max_length"]
      end

      def render(_responses)
        output = label.dup
        output << "\n   You can enter at least <#{@min}> characters." if @min
        output << "\n   You can enter at most <#{@max}> characters." if @max
        output
      end
    end
  end
end
