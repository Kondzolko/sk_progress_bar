# SkProgressBar (Progress Bar For Sidekiq worker)
[![Watch the video](http://i3.ytimg.com/vi/B4xov2rMtAA/maxresdefault.jpg)](https://www.youtube.com/embed/B4xov2rMtAA)
## Rails version
    from rails 5.0 up to 6.0

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'sk_progress_bar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sk_progress_bar
    
## Database setup (if needed)
(ActiveRecord only) Create migration for Sidekiq Progress Bar and migrate the database (in your Rails project):

    rails g sk_progress_bar:migration
    rake db:migrate

## Add ProgressBar model (if needed)
    rails g sk_progress_bar:models

## Setup action cable (Required)
    rails g sk_progress_bar:channel
    
## Routes (Required)
    mount ActionCable.server, at: '/cable'
    
## Required gems
    gem 'sidekiq'
    
    gem 'bootstrap' 
    # "Boostrap" need if you will use progress bar from "bootstrap"
## Usage
    require 'sk_progress_bar'
    
    index = 0
    objects = 10
    
    progress = SkProgressBar.progress_status(index, objects)
    # progress => {:percentage=>10, :message=>"Almost done"}
    # Calculate and return how many percent of the work done on the total amount of work
    
    SkProgressBar.update_progress_bar(10, Almost done, 46b26c4df9a6c0e2603552bf)
    # Update Html Progress Bar
    
    SkProgressBar.create_update_db(progress[:percentage], progress[:message], jid)
    # Create/Update Record in DB
    
## Example Html Code with Bootstrap
    <div class="progress">
      <div class="progress-bar progress-bar-striped" role="progressbar" style="width: 2%" aria-valuenow="10" aria-valuemin="2" aria-valuemax="100"></div>
    </div>

## Example Haml Code with Bootstrap
    .progress
      .progress-bar.progress-bar-striped{"aria-valuemax" => "100", "aria-valuemin" => "2", "aria-valuenow" => "10", :role => "progressbar", :style => "width: 2%"}


## Example Worker Code
    /app/workers/progress_bar_worker.rb
    
    
    class ProgressBarWorker
      include Sidekiq::Worker
      require 'sk_progress_bar'
    
      def perform
        objects = [*1..10]
        # objects => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        start_cycle(objects)
      end
    
      def start_cycle(objects)
        objects.each_with_index do |object, index|
          sleep(0.5)
    
          progress = SkProgressBar.progress_status(index, objects.count)
          # progress => {:percentage=>10, :message=>"Almost done"}
          # jid => Sidekiq Process ID (46b26c4df9a6c0e2603552bf)
    
          SkProgressBar.update_progress_bar(progress[:percentage], progress[:message], jid)
          # Update Html Progress Bar
          
          SkProgressBar.create_update_db(progress[:percentage], progress[:message], jid)
          # Create/Update Record in DB
        end
      end
    end

## Rails console
    ProgressBarWorker.perform_async
    or
    ProgressBarWorker.new.perform
    
    # Important (Only for ".new.perform")
        When you are using the method ".new.perform" in SidekiqWorker and you need to use 
        "SkProgressBar.create_update_db" method to save results in DB, please add a unique 
        "jid" variable in order to avoid duplicated records in the DB.
        
        "Example: SkProgressBar.create_update_db(progress[:percentage], progress[:message], jid)"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Kondzolko/sk_progress_bar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SkProgressBar project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sk_progress_bar/blob/master/CODE_OF_CONDUCT.md).

## Author
    Andriy Kondzolko