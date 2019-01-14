require 'sinatra/base'
require 'sinatra/cross_origin'
require 'mime/types'

class Mumukit::Server::App < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, '*'
    set :public_folder, 'public'
  end

  def self.get_asset(route, absolute_path, type)
    get "/assets/#{route}" do
      send_file absolute_path, type: type
    end
  end

  def self.get_gui_asset(route, path, type)
    get_asset route, Scratch::GUI.assets_path_for(path), type
  end
  
  def self.get_local_asset(route, path, type)
    get_asset route, File.join(__dir__, '..', path), type
  end

  def send_public_file(path, extension)
    absolute_path = Scratch::GUI.public_path_for("#{path}.#{extension}")
    send_file absolute_path, type: MIME::Types.type_for(extension)
  end
  
  get_gui_asset 'editor/gui.js', 'javascripts/gui.js', 'application/javascript'
  get_gui_asset 'editor/lib.min.js', 'javascripts/lib.min.js', 'application/javascript'
  get_local_asset 'editor/editor.js', 'lib/render/editor/editor.js', 'application/javascript'
  get_local_asset 'editor/editor.css', 'lib/render/editor/editor.css', 'text/css'

  get '/static/*.*' do |path, extension|
    send_public_file path, extension
  end
end
