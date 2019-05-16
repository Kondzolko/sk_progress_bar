require 'generators/sk_progress_bar'
require 'rails/generators/active_record'

module SkProgressBar
  module Generators
    # Sidekiq Progress Bar generator that creates model file from template
    class ModelsGenerator < ActiveRecord::Generators::Base
      extend Base

      argument :name, :type => :string, :default => 'sk_progress_bar'
      # Create model file
      def generate_files
        copy_file 'progress_bar.rb', "app/models/#{name}.rb"
      end
    end
  end
end