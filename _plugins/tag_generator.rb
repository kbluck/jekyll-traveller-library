require 'set'

module Jekyll
  # Synthetic page — no source file on disk.
  class TagPage < Page
    def initialize(site, base, tag, slug)
      @site = site
      @base = base
      @dir  = File.join('tags', slug)
      @name = 'index.html'

      process(@name) # sets self.basename and self.ext

      self.data = {
        'layout'    => 'tag',
        'tag'       => tag,
        'title'     => tag.split('-').map(&:capitalize).join(' '),
        'permalink' => "/tags/#{slug}/"
      }
      self.content = ''
    end
  end

  class TagGenerator < Generator
    safe     true
    priority :low

    def generate(site)
      collect_tags(site).each do |tag|
        slug = Jekyll::Utils.slugify(tag)
        site.pages << TagPage.new(site, site.source, tag, slug)
      end
    end

    private

    def collect_tags(site)
      tags = Set.new

      site.posts.docs.each do |doc|
        (doc.data['tags'] || []).each { |t| tags << t.to_s }
      end

      site.collections.each_value do |collection|
        collection.docs.each do |doc|
          (doc.data['tags'] || []).each { |t| tags << t.to_s }
        end
      end

      tags.to_a.sort
    end
  end
end
