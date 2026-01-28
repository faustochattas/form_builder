# frozen_string_literal: true

require "stringio"

RSpec.describe FormBuilder::Questionnaire do
  it "prints only visible questions and numbers them sequentially" do
    config = {
      "id" => "test_form",
      "title" => "Test Form",
      "questions" => [
        {
          "id" => "q1",
          "type" => "text",
          "label" => "Name?",
          "min_length" => 1,
          "max_length" => 10
        },
        {
          "id" => "q2",
          "type" => "text",
          "label" => "Alias?",
          "max_length" => 200,
          "visible_if" => { "value" => { "question" => "has_alias", "equals" => true } }
        }
      ]
    }

    q = FormBuilder::Questionnaire.new(config)

    out = StringIO.new
    $stdout = out
    begin
      q.print({ "test_form" => { "has_alias" => false } })
    ensure
      $stdout = STDOUT
    end

    text = out.string
    expect(text).to include("TEST FORM")
    expect(text).to include("1. Name?")
    expect(text).not_to include("2. Alias?")
  end
end
