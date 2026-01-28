# frozen_string_literal: true

require "yaml"
require "json"
require "json-schema"
require_relative "questionnaire"

module FormBuilder
  class ConfigLoader
    SCHEMA_PATH = File.expand_path("../../config/schema/questionnaire_schema.json", __dir__)

    def self.load(path)
      data = YAML.load_file(path)

      schema = JSON.parse(File.read(SCHEMA_PATH))
      JSON::Validator.validate!(schema, data)

      Questionnaire.new(data)
    end
  end
end
