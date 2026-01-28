# frozen_string_literal: true

module FormBuilder
  module Presets
    GENDERS = [
      { label: "Male", value: "male" },
      { label: "Female", value: "female" },
      { label: "X", value: "x" }
    ]

    ETHNICITIES = [
      { label: "White", value: "white" },
      { label: "Black", value: "black" },
      { label: "Asian", value: "asian" },
      { label: "Hispanic", value: "hispanic" }
    ]

    US_STATES_5 = [
      { label: "California", value: "ca" },
      { label: "Florida", value: "fl" },
      { label: "New York", value: "ny" },
      { label: "Texas", value: "tx" },
      { label: "Washington", value: "wa" }
    ]

    COUNTRIES_3 = [
      { label: "Canada", value: "ca" },
      { label: "Mexico", value: "mx" },
      { label: "United States", value: "us" }
    ]

    def self.resolve(name)
      case name.to_s
      when "genders" then GENDERS
      when "ethnicities" then ETHNICITIES
      when "us_states_5" then US_STATES_5
      when "countries_3" then COUNTRIES_3
      else
        raise "Unknown preset: #{name}"
      end
    end
  end
end