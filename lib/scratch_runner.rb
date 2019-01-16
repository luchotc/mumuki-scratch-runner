require 'mumukit'
require 'erb'

I18n.load_translations_path File.join(__dir__, 'locales', '*.yml')

Mumukit.runner_name = 'scratch'
Mumukit.configure do |config|
  config.docker_image = 'mumuki/mumuki-scratch-worker:1.1'
  config.content_type = 'html'
  config.structured = true
end

require_relative './scratch'
require_relative './extensions/string'
require_relative './assets_server'

require_relative './metadata_hook'
require_relative './precompile_hook'
require_relative './version_hook'
require_relative './expectations_hook'
