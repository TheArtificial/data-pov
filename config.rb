###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do

  def nav_link(link_text, url, options = {})
    options[:class] ||= ""
    options[:class] << " current" if current_resource.url.start_with?(url)
    link_to(link_text, url, options)
  end

  def find_image(base_path)
    if found = sitemap.find_resource_by_path(base_path+'.png')
      return found
    elsif found = sitemap.find_resource_by_path(base_path+'.jpg')
      return found
    else
      return nil
    end
  end

  # this overrides the built-in helper
  # see https://github.com/middleman/middleman/issues/145
  def extra_page_classes
    path_classes = page_classes.split(' ')

    blog_classes = []
    if current_page.data.tags
      blog_classes << current_page.data.tags.split(',').map{|t| "tag-#{t.strip.gsub(/\s+/, '-')}"}
    end
    if current_page.data.category
      blog_classes << "category-#{current_page.data.category.strip.gsub(/\s+/, '-')}"
  end
    classes = path_classes + blog_classes

    return classes.join(' ')
  end

end # helpers

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :development do
  require 'lib/rack_validate'
  use ::Rack::Validate
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
