author       'Daniel Mendler'
description  'Tree Viewer'
dependencies 'misc/sidebar'

class Wiki::App

  hook(:after_head) do
    '<link rel="stylesheet" href="/_/treeview/treeview.css" type="text/css"/>'
  end

  hook(:after_script) do
    '<script src="/_/treeview/script.js" type="text/javascript"></script>'
  end

  assets 'script.js',
         '*.png',
         'spinner.gif',
	 'treeview.css'

  get '/_/treeview.json' do
    require 'json'

    content_type 'application/json', :charset => 'utf-8'

    resource = Resource.find!(repository, params[:dir], params[:version])
    cache_control :max_age => 3600, :s_maxage => 0, :proxy_revalidate => true, :etag => resource.latest_commit.id, :last_modified => resource.latest_commit.date

    resource.children.map do |child|
      ext = !child.page? || child.extension.empty? ? '' : " file-type-#{child.extension.downcase}"
      [child.tree? ? 1 : 0, child.tree? && !child.children.empty? ? 1 : 0, child.tree? ? 'tree' : 'page' + ext, resource_path(child), child.name]
    end.to_json
  end
end
