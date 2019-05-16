# frozen_string_literal: true

require 'rails/generators/named_base'

module SkProgressBar
  # A generator module with SkProgressBar table schema.
  module Generators
    # A base module
    module Base
      # Get path for migration template
      def source_root
        @_sk_progress_bar_source_root ||= File.expand_path(File.join('../sk_progress_bar', generator_name, 'templates'), __FILE__)
      end
    end
  end
end