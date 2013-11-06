Spree Banner
============

Adds a way to manage banners to Spree Commerce [compatible with Amazon S3]


Installation
------------

1. Add the following to your Gemfile

```ruby
gem 'spree_banner', '~> 2.0.0'
```

2. Run `bundle install`

3. To copy and apply migrations run:

```
rails g spree_banner:install
```


Configuration
-------------

Preferences can be updated within the admin panel under "Configuration" then "Banner box settings".
Or you may set them with an initializer within your application:

```ruby
SpreeBanner::Config.tap do |config|
  config.banner_styles = {"mini" => "48x48>", "small" => "100x100>", "large" => "800x200#"}.to_json.to_s
  config.banner_default_style = 'small'
end
```


Banner use example
------------------

1. Add banner helper method in your view:

```erb
<%= insert_banner_box(category: "my_category") %>
```

2. Additional options:

```ruby
  :class => "my_class"
  :style => "my_style"
  :list = true|false
```

Copyright (c) 2012 [Damiano Giacomello], released under the New BSD License
