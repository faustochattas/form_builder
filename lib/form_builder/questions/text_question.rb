# frozen_string_literal: true

module FormBuilder
  module Questions
    class TextQuestion < BaseQuestion
      def initialize(config)
        super
        @min = config["min_length"]
        @max = config["max_length"]
      end

      def render_body(_responses)
        lines = []
        lines << "   You can enter at least <#{@min}> characters." if @min
        lines << "   You can enter at most <#{@max}> characters." if @max
        lines.join("\n")
      end
    end
  end
end