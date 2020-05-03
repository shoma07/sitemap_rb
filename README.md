# SitemapRb

Simple Sitemap Generator of Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sitemap_rb', git: 'https://github.com/shoma07/sitemap_rb.git'
```

And then execute:

```sh
$ bundle install
```

## Usage

```ruby
sitemap = SitemapRb::Sitemap.new
sitemap.add('http://example.com')
# sitemap.add('http://example.com', changefreq: 'always', priority: 0.5)
sitemap.generate
```

### changefreq

- always
- hourly
- daily
- weekly
- monthly
- yearly
- never

### priority

0.0 ~ 1.0

### pretty generate

```ruby
sitemap.generate(pretty: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sitemap_rb.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
