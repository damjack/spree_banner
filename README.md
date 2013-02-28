SpreeBanner
===================

Add banner for Spree Commerce Shop [compatible with Amazon S3]


Basic Installation
------------------

1. Add the following to your Gemfile
<pre>
  gem 'spree_banner', '~> 1.1.4'
</pre>
2. Run `bundle install`
3. To copy and apply migrations run:
<pre>
	rails g spree_banner:install
</pre>

Example
=======

1. add banner helper method in your view:
<pre>
	<%= insert_banner %>
</pre>
and add banner in the admin section
2. Additional options:
<pre>
	<%= insert_banner(:category => "my_category") %>
</pre>
displays banner for which the category column, dafault is ""
<pre>
	<%= insert_banner(:max => 10) %>
</pre>
limits the number of banner shown to 10 (default 1)
<pre>
	<%= insert_banner(:class => "your_class") %>
</pre>
set banner class (default banner)
<pre>
	<%= insert_banner(:list => true/false) %>
</pre>
set banner container (default false is DIV)

Copyright (c) 2012 [Damiano Giacomello], released under the New BSD License
