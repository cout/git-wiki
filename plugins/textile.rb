require 'redcloth'

module Wiki
  Mime.add('text/x-textile', %w(textile), %w(text/plain))

  Engine.create(:textile, 1, true) do
    accepts {|page| page.mime == 'text/x-textile' }
    output  {|page| fix_punctuation(RedCloth.new(page.content).to_html) }
  end
end