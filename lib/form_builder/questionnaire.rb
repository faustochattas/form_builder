# frozen_string_literal: true

require_relative "questions/base_question"

module FormBuilder
  class Questionnaire
    attr_reader :id, :title, :questions

    def initialize(config)
      @id = config["id"]
      @title = config["title"]
      @questions = (config["questions"] || []).map do |q|
        Questions::BaseQuestion.build(q)
      end
    end

    def print(responses)
      form_responses = responses[id] || {}

      puts
      puts title.upcase
      puts

      number = 1
      questions.each do |question|
        next unless question.visible?(form_responses)

        puts "#{number}. #{question.render(form_responses)}"
        question.visibility_lines.each { |line| puts "  #{line}" }
        puts

        number += 1
      end
    end
  end
end