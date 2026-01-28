# frozen_string_literal: true

RSpec.describe "Visibility conditions" do
  let(:base_question_class) { FormBuilder::Questions::BaseQuestion }

  def build_question(config)
    base_question_class.build(config)
  end

  it "supports value condition" do
    q = build_question(
      "id" => "alias",
      "type" => "text",
      "label" => "What is your alias?",
      "max_length" => 200,
      "visible_if" => {
        "value" => { "question" => "have_alias", "equals" => true }
      }
    )

    expect(q.visible?({ "have_alias" => true })).to eq(true)
    expect(q.visible?({ "have_alias" => false })).to eq(false)
  end

  it "supports and condition" do
    q = build_question(
      "id" => "state",
      "type" => "dropdown",
      "label" => "State",
      "preset" => "us_states_5",
      "visible_if" => {
        "and" => [
          { "value" => { "question" => "live_in_us", "equals" => true } },
          { "value" => { "question" => "which_situation", "equals" => "dv" } }
        ]
      }
    )

    expect(q.visible?({ "live_in_us" => true, "which_situation" => "dv" })).to eq(true)
    expect(q.visible?({ "live_in_us" => true, "which_situation" => "sa" })).to eq(false)
    expect(q.visible?({ "live_in_us" => false, "which_situation" => "dv" })).to eq(false)
  end

  it "supports or condition" do
    q = build_question(
      "id" => "country",
      "type" => "dropdown",
      "label" => "Country",
      "preset" => "countries_3",
      "visible_if" => {
        "or" => [
          { "value" => { "question" => "live_in_us", "equals" => false } },
          { "value" => { "question" => "override", "equals" => true } }
        ]
      }
    )

    expect(q.visible?({ "live_in_us" => false })).to eq(true)
    expect(q.visible?({ "override" => true })).to eq(true)
    expect(q.visible?({ "live_in_us" => true, "override" => false })).to eq(false)
  end

  it "supports not condition" do
    q = build_question(
      "id" => "country",
      "type" => "dropdown",
      "label" => "Country",
      "preset" => "countries_3",
      "visible_if" => {
        "not" => { "value" => { "question" => "live_in_us", "equals" => true } }
      }
    )

    expect(q.visible?({ "live_in_us" => false })).to eq(true)
    expect(q.visible?({ "live_in_us" => true })).to eq(false)
  end

  it "prints visibility lines with correct prefixes" do
    q = build_question(
      "id" => "state",
      "type" => "dropdown",
      "label" => "State",
      "preset" => "us_states_5",
      "visible_if" => {
        "and" => [
          { "value" => { "question" => "live_in_us", "equals" => true } },
          { "value" => { "question" => "which_situation", "equals" => "dv" } }
        ]
      }
    )

    lines = q.visibility_lines
    expect(lines).to include("<AND Visible> live_in_us: true")
    expect(lines).to include("<AND Visible> which_situation: \"dv\"")
  end
end
