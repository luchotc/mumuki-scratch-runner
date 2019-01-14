require_relative '../lib/scratch_runner'
require 'rspec'

FIXTURES_PATH = "fixtures/files/"

def file_fixture(filename)
  filepath = File.join(__dir__,  FIXTURES_PATH, filename)
  File.read filepath
end