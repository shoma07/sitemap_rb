# frozen_string_literal: true

require_relative 'lib/sitemap_rb/version'

Gem::Specification.new do |spec|
  spec.name          = 'sitemap_rb'
  spec.version       = SitemapRb::VERSION
  spec.authors       = ['shoma07']
  spec.email         = ['23730734+shoma07@users.noreply.github.com']

  spec.summary       = 'Sitemap Generator of Ruby'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/shoma07/sitemap_rb'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
