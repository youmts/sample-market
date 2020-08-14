# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

2.6.3

* System dependencies

need postgresql

* Configuration

none

* Database creation

```
bin/rails db:create
bin/rails db:migrate
```

* Database initialization
```
bin/rails console
Admin.create(email: 'admin@example.com', password: 'password')
```

* How to run the test suite
```
bin/rspec
```

* How to run the server

```
bin/rails server
```

* Services (job queues, cache servers, search engines, etc.)

none

* Deployment instructions

in aws ec2
```
cd /var/www/rails/sample-market/

bin/rake assets:precompile RAILS_ENV=production

kill -QUIT `cat tmp/pids/unicorn.pid`
bundle exec unicorn_rails -c config/unicorn.conf.rb -D -E production

sudo service nginx start
```
