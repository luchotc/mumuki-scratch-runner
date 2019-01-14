class ScratchMetadataHook < Mumukit::Hook
  def metadata
    {
      language: {
        name: 'scratch',
        icon: {type: 'devicon', name: 'scratch'},
        version: 'v1.0.0',
        extension: 'json',
        ace_mode: 'scratch',
        graphic: true
      },
      layout_assets_urls: {
        html: []
      },
      editor_assets_urls: {
        js: [
          'assets/editor/lib.min.js',
          'assets/editor/gui.js',
          'assets/editor/editor.js',
        ],
        html: [],
        css: [
          'assets/editor/editor.css'
        ]
      }
    }
  end
end
