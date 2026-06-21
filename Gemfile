source "https://rubygems.org"

gem "jekyll", "~> 4.4.1"
gem "minima", "~> 2.5.2"

# Jekyll plugins are gems that extend the functionality of Jekyll. They can be
# be used to add new features, modify existing behavior, or integrate with
# other services. 

group :jekyll_plugins do

  # If you want to use GitHub Pages, remove the "gem "jekyll"" above and
  # uncomment the line below. To upgrade, run `bundle update github-pages`.
  # gem "github-pages"

  # The `jekyll-feed` plugin generates an Atom feed for a Jekyll site, which
  # can be used by feed readers to subscribe to updates from the site.
  gem "jekyll-feed", "~> 0.12"
end

platforms :jruby, :windows do

  # Windows and JRuby do not include timezone by default.
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

platforms :jruby do

  # Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions
  # do not have a Java counterpart.
  gem "http_parser.rb", "~> 0.6.0"
end

platforms :windows do

  # Performance improvement when watching directories on Windows.
  gem "wdm", "~> 0.1"
end
