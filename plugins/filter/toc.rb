author       'Daniel Mendler'
description  'Auto-generated table of contents'
dependencies 'engine/filter', 'filter/tag', 'gem:nokogiri'
autoload 'Nokogiri', 'nokogiri'

class Toc < Filter
  def filter(content)
    return content if !context.private[:toc]
    @toc = '<div class="toc">'
    @level = 0
    @doc = Nokogiri::HTML::DocumentFragment.parse(content)
    @count = [0]

    elem = (@doc/'h1,h2,h3,h4,h5,h6').first
    @offset = elem ? elem.name[1..1].to_i - 1 : 0

    @doc.traverse {|child| headline(child) if child.name =~ /^h(\d)$/ }

    while @level > 0
      @level -= 1
      @toc << '</li></ul>'
    end
    @toc << '</div>'

    content = @doc.to_xhtml

    content.gsub!(context.private[:toc]) do
      prefix = $`
      count = prefix.scan('<p>').size - prefix.scan('</p>').size
      count > 0 ? '</p>' + @toc + '<p>' : @toc
    end
    content.gsub!(%r{<p>\s*</p>}, '')

    content
  end

  private

  def headline(elem)
    nr = elem.name[1..1].to_i - @offset
    if nr > @level
      while nr > @level
        @toc << '<ul>'
        @count[@level] = 0
        @level += 1
        @toc << '<li>' if nr > @level
      end
    else
      while nr < @level
        @level -= 1
        @toc << '</li></ul>'
      end
      @toc << '</li>'
    end
    @count[@level-1] += 1
    headline = elem.children.first ? elem.children.first.inner_text : ''
    section = 'section-' + @count[0..@level-1].join('_') + '_' + headline.strip.gsub(/[^\w]/, '_')
    @toc << %{<li class="toc#{@level-@offset+1}"><a href="##{section}">\
<span class="counter">#{@count[@level-1]}</span> #{headline}</a>}
    elem.inner_html = %{<span class="counter" id="#{section}">#{@count[0..@level-1].join('.')}</span> #{elem.inner_html}}
  end
end

Tag.define(:toc, :immediate => true) do |context, attrs, content|
  context.private[:toc] ||= "TOC_#{unique_id}"
end

Filter.register Toc.new(:toc)
