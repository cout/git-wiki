README
======

Git-Wiki is a wiki that stores pages in a [Git][] repository.

See the demo installation at <http://git-wiki.kicks-ass.org/>.

Features
--------

A lot of the features are implemented as plugins.

- History
- Show diffs
- Edit page, upload files
- Section editing
- Plugin system
- Multiple renderers
- LaTeX/Graphviz
- Syntax highlighting (embedded code blocks)
- Image support, SVG support
- Auto-generated table of contents (via nokogiri)
- Templates
- XML tag soup can be used to extend Wiki syntax

Installation
------------

First, you have to install the [Gem][] dependencies via `gem`:

    gem sources -a http://gemcutter.org
    gem install creole
    gem install gitrb
    gem install mimemagic
    gem install haml
    gem install rack
    gem install mongrel --source http://gems.rubyinstaller.org

    # other rack-esi implementations should also work
    # just try it
    gem install minad-rack-esi

    # this is a more current version of rack-cache with bugfixes
    # TODO: replace this with official release when new version is released
    gem install minad-rack-cache

### Optional:

    gem install nokogiri
    gem install rdiscount
    gem install RedCloth
    gem install maruku
    gem install rubypants
    gem install imaginator
    gem install evaluator
    gem install rack-embed

Then, run the program using the command:

    ./run.ru -smongrel -p4567

Point your web browser at <http://localhost:4567>.

### Notes:

Git-Wiki automatically creates a repository in the directory `./.wiki`.

For production purposes, I recommend that you deploy the wiki
with Mongrel. You can use the WIKI_CONFIG environment variable
to specify multiple wiki configurations.

Dependencies
------------

- [HAML][]
- [gitrb][]

### Optional Dependencies

- [nokogiri][] for auto-generated table of contents
- [imaginator][] for [LaTeX][]/[GraphViz][] output
  (`imaginator` Gem from [gemcutter][])
- [Pygments][] for syntax highlighting
- [ImageMagick][] for image scaling and svg rendering
- [RubyPants][] to fix punctuation

### Dependencies for page rendering

At least one of these renderers should be installed:

- [creole][] for creole wikitext rendering
  (`creole` Gem from [gemcutter][])
- [RDiscount][] for Markdown rendering
- [RedCloth][] for Textile rendering

[creole]:http://github.com/minad/creole
[Gem]:http://rubygems.org
[Git]:http://www.git-scm.org
[GitHub]:http://github.com
[GraphViz]:http://www.graphviz.org
[HAML]:http://haml.hamptoncatlin.com
[nokogiri]:http://nokogiri.org/
[imaginator]:http://github.com/minad/imaginator
[LaTeX]:www.latex-project.org
[pygments]:http://pygments.org/
[RDiscount]:http://github.com/rtomayko/rdiscount
[RedCloth]:http://redcloth.org/
[ImageMagick]:http://www.imagemagick.org/
[gitrb]:http://github.com/minad/gitrb/
[gemcutter]:http://gemcutter.org/
[RubyPants]:http://chneukirchen.org/blog/static/projects/rubypants.html
