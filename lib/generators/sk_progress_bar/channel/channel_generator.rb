require 'generators/sk_progress_bar'
require 'rails/generators/active_record'

module SkProgressBar
  module Generators
    # Sidekiq Progress Bar generator that creates action_cable files from template
    class ChannelGenerator < ActiveRecord::Generators::Base
      extend Base

      argument :name, :type => :string, :default => 'sk_progress_bar'
      # Add action cable in project's folder
      def generate_files
        copy_file 'sk_progress_bar.rb', "app/channels/#{name}.rb"
        copy_file 'sk_progress_bar.coffee', "app/assets/javascripts/channels/#{name}.coffee"
      end
    end
  end
end