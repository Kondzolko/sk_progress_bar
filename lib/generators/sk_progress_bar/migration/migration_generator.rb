require 'generators/sk_progress_bar'
require 'rails/generators/active_record'


module SkProgressBar
  module Generators
    # Migration generator that creates migration file from template
    class MigrationGenerator < ActiveRecord::Generators::Base
      extend Base

      argument :name, :type => :string, :default => 'create_activities'
      # Create migration in project's folder
      def generate_files
        migration_template 'migration.rb', "db/migrate/#{name}.rb"
      end
    end
  end
end