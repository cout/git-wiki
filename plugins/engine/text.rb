author      'Daniel Mendler'
description 'Text engine'

# Text engine. Renders text content.
Engine.create(:text, :priority => 999, :layout => false) do
  def accepts?(page); page.mime.text?; end
  def mime(page); 'text/plain'; end
end
