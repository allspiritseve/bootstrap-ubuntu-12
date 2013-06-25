# Bootstrap a Ruby / Rails / Sinatra server on Ubuntu 12.10

## Philosophy
This code is meant to be informative and is not written to be fast or
efficient. I want you to be able to read through every line of code in this
repository and know exactly what it is doing. If you see something you don't
understand, research it! Use Google, or find someone to teach it to you.

## My stack:
* Ubuntu 12.10
* [Chruby](https://github.com/postmodern/chruby)
* Git
* [Mandrill](https://mandrillapp.com)
* Memcached
* Monit
* Nginx
* Postgresql 9.2
* [Puma](http://puma.io)
* Rails 4.0
* Ruby 2.0.0-p0
* [Sidekiq](https://github.com/mperham/sidekiq)

## Organization
* `bootstrap.sh` - provision your server
* `system/` - server config files
* `bin/` - useful scripts
* `rails/` - rails-specific config
* `sinatra/` - sinatra-specific config

## Contributing
1. Fork it
1. Create your feature branch (git checkout -b my-new-feature)
1. Stage your changes (git add -p)
1. Commit your changes (git commit)
1. Push to Github (git push -u origin my-new-feature)
1. Create new Pull Request
