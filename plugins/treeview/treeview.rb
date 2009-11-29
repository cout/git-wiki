dependencies 'misc/sidebar'
author       'Daniel Mendler'
description  'Tree Viewer'

class Wiki::App

  add_hook(:after_head) do
    '<link rel="stylesheet" href="/sys/treeview/treeview.css" type="text/css"/>' +
      '<script src="/sys/treeview/script.js" type="text/javascript"></script>'
  end

  public_files 'script.js',
               'expanded.png',
               'collapsed.png',
               'spinner.gif',
	       'treeview.css'

  get '/sys/treeview.json' do
    content_type 'application/json', :charset => 'utf-8'

    resource = Resource.find!(repository, params[:dir], params[:sha])
    cache_control :etag => resource.latest_commit.id, :last_modified => resource.latest_commit.date

    result = '[';
    result << resource.children.map do |child|
      ext = child.page? && child.extension.empty? ? '' : " file-type-#{ext}"
      "[#{child.tree? && !child.children.empty?},'#{child.tree? ? 'tree' : 'page' + ext}','#{resource_path(child)}','#{child.name}']"
    end.join(',')
    result << ']'
  end
end
