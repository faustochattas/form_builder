# frozen_string_literal: true

require "yaml"
require_relative "lib/form_builder/config_loader"

def parse_arg(flag)
  idx = ARGV.index(flag)
  return nil unless idx
  ARGV[idx + 1]
end

config_arg = parse_arg("--config")
responses_arg = parse_arg("--responses")

if config_arg.nil? || responses_arg.nil?
  puts "Usage:"
  puts "  ruby questionnaire.rb --config config/personal_information.yaml,config/about_the_situation.yaml --responses config/user_response.yaml"
  exit 1
end

config_paths = config_arg.split(",").map(&:strip)
responses = YAML.load_file(responses_arg)

questionnaires = config_paths.map { |path| FormBuilder::ConfigLoader.load(path) }
questionnaires.each { |q| q.print(responses) }
