# frozen_string_literal: true

module FormBuilder
  module Questions
    class BaseQuestion
      attr_reader :id, :label, :visible_if

      def initialize(config)
        @id = config["id"]
        @label = config["label"]
        @visible_if = config["visible_if"]
      end

      def visible?(responses)
        return true unless visible_if
        evaluate_condition(visible_if, responses)
      end

      def visibility_lines
        return [] unless visible_if
        format_condition_lines(visible_if)
      end

      def render(_responses)
        raise NotImplementedError, "Subclasses must implement #render"
      end

      def self.build(config)
        case config["type"]
        when "text"
          require_relative "text_question"
          FormBuilder::Questions::TextQuestion.new(config)
        when "boolean"
          require_relative "boolean_question"
          FormBuilder::Questions::BooleanQuestion.new(config)
        when "radio"
          require_relative "radio_question"
          FormBuilder::Questions::RadioQuestion.new(config)
        when "checkbox"
          require_relative "checkbox_question"
          FormBuilder::Questions::CheckboxQuestion.new(config)
        when "dropdown"
          require_relative "dropdown_question"
          FormBuilder::Questions::DropdownQuestion.new(config)
        else
          raise "Unknown question type: #{config['type']}"
        end
      end

      private

      def evaluate_condition(condition, responses)
        if condition["value"]
          q = condition["value"]["question"]
          expected = condition["value"]["equals"]
          responses[q] == expected
        elsif condition["and"]
          condition["and"].all? { |c| evaluate_condition(c, responses) }
        elsif condition["or"]
          condition["or"].any? { |c| evaluate_condition(c, responses) }
        elsif condition["not"]
          !evaluate_condition(condition["not"], responses)
        else
          true
        end
      end

      def format_condition_lines(condition, prefix = "Visible")
        if condition["value"]
          q = condition["value"]["question"]
          expected = condition["value"]["equals"]
          ["<#{prefix}> #{q}: #{expected.inspect}"]
        elsif condition["and"]
          condition["and"].flat_map { |c| format_condition_lines(c, "AND Visible") }
        elsif condition["or"]
          condition["or"].flat_map { |c| format_condition_lines(c, "OR Visible") }
        elsif condition["not"]
          format_condition_lines(condition["not"], "NOT Visible")
        else
          []
        end
      end
    end
  end
end
