# frozen_string_literal: true

RSpec.describe SitemapRb::Sitemap do
  subject { sitemap.generate(pretty: true) }
  let(:sitemap) { described_class.new }
  let(:text) { File.read('spec/data/example.xml').chomp }
  let(:lastmod) { Time.new(2020, 5, 3, 17, 47, 12) }

  before do
    sitemap.add('http://example.com', lastmod: lastmod)
  end
  it { is_expected.to eq text }
end
