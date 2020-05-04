# frozen_string_literal: true

module SitemapRb
  # # SitemapRb::Sitemap
  # @see [Sitemaps XML format](https://www.sitemaps.org/protocol.html)
  class Sitemap
    CHANGEFREQS = %w[
      always
      hourly
      daily
      weekly
      monthly
      yearly
      never
    ].freeze

    URLSET_ATTRIBUTES = {
      'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
      'xsi:schemaLocation' => 'http://www.sitemaps.org/schemas/sitemap/0.9 ' \
      'http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd',
      'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9',
      'xmlns:image' => 'http://www.google.com/schemas/sitemap-image/1.1',
      'xmlns:video' => 'http://www.google.com/schemas/sitemap-video/1.1',
      'xmlns:news' => 'http://www.google.com/schemas/sitemap-news/0.9',
      'xmlns:mobile' => 'http://www.google.com/schemas/sitemap-mobile/1.0',
      'xmlns:pagemap' => 'http://www.google.com/schemas/sitemap-pagemap/1.0',
      'xmlns:xhtml' => 'http://www.w3.org/1999/xhtml'
    }.freeze

    SEARCH_ENGINES = %w[
      http://www.google.com/webmasters/tools/ping?sitemap=
      http://www.bing.com/ping?sitemap=
    ].freeze

    class << self
      # @param [String] sitemap_url
      # @return [void]
      def ping_search_engines(sitemap_url)
        SEARCH_ENGINES.each do |url|
          OpenURI.open_uri(url + CGI.escape(sitemap_url), { read_timeout: 10 })
        end
      end
    end

    # @return [SitemapRb::Sitemap]
    def initialize
      @doc = REXML::Document.new(
        nil,
        { prologue_quote: :quote, attribute_quote: :quote }
      )
      @doc.add(REXML::XMLDecl.new('1.0', 'UTF-8'))
      @urlset = REXML::Element.new('urlset')
      @urlset.add_attributes(URLSET_ATTRIBUTES)
      @doc.add_element(@urlset)
      @lastmod = Time.now
    end

    # @param [String] loc
    # @param [String] changefreq
    # @param [Float] priority
    # @param [Time] lastmod
    # @return [REXML::Element]
    def add(loc, changefreq: 'always', priority: 0.5, lastmod: nil)
      url = REXML::Element.new('url')
      url.add_element(create_loc_element(loc))
      url.add_element(create_lastmod_element(lastmod || @lastmod))
      url.add_element(create_changefreq_element(changefreq))
      url.add_element(create_priority_element(priority))
      @urlset.add_element(url)
    end

    # @param [TrueClass, FalseClass] pretty
    # @return [String]
    def generate(pretty: false)
      io = StringIO.new
      formatter(pretty).write(@doc, io)
      io.string
    end

    private

    # @param [String] loc
    # @return [REXML::Element]
    # @raise [ArgumentError]
    def create_loc_element(loc)
      raise ArgumentError unless URI.parse(loc).scheme.to_s.start_with?('http')

      REXML::Element.new('loc').add_text(loc)
    end

    # @param [Time] lastmod
    # @return [REXML::Element]
    def create_lastmod_element(lastmod)
      REXML::Element.new('lastmod').add_text(lastmod.strftime('%FT%T%:z'))
    end

    # @param [String] changefreq
    # @return [REXML::Element]
    # @raise [ArgumentError]
    def create_changefreq_element(changefreq)
      raise ArgumentError unless CHANGEFREQS.include?(changefreq)

      REXML::Element.new('changefreq').add_text(changefreq)
    end

    # @param [Float] priority
    # @return [REXML::Element]
    # @raise [ArgumentError]
    def create_priority_element(priority)
      raise ArgumentError unless priority.between?(0.0, 1.0)

      REXML::Element.new('priority')
                    .add_text(format('%<priority>.01f', priority: priority))
    end

    # @param [TrueClass, FalseClass] pretty
    # @return [REXML::Formatters::Pretty, REXML::Formatters::Default]
    def formatter(pretty)
      pretty ? REXML::Formatters::Pretty.new : REXML::Formatters::Default.new
    end
  end
end
