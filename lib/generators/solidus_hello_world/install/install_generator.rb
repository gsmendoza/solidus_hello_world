# frozen_string_literal: true

module SolidusHelloWorld
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :auto_run_migrations, type: :boolean, default: false
      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        template 'initializer.rb', 'config/initializers/solidus_hello_world.rb'
      end

      def copy_starter_frontend_files
        return unless starter_frontend_available?

        directory 'frontend/app/assets', 'app/assets'
        directory 'frontend/app/controllers', 'app/controllers'
        directory 'frontend/app/views', 'app/views'

        copy_file 'frontend/config/routes.rb', 'tmp/routes.rb'
        prepend_file 'config/routes.rb', File.read('tmp/routes.rb')
      end

      def add_javascripts
        if starter_frontend_available?
          append_file 'app/assets/javascripts/spree/frontend.js',
            "//= require spree/frontend/solidus_hello_world\n"

        elsif SolidusSupport.frontend_available?
          append_file 'vendor/assets/javascripts/spree/frontend/all.js',
            "//= require spree/frontend/solidus_hello_world\n"
        end

        append_file 'vendor/assets/javascripts/spree/backend/all.js',
          "//= require spree/backend/solidus_hello_world\n"
      end

      def add_stylesheets
        if starter_frontend_available?
          append_file 'app/assets/stylesheets/spree/frontend/solidus_starter_frontend.css',
            "/*= require spree/frontend/solidus_hello_world */\n"

        elsif SolidusSupport.frontend_available?
          inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css',
            " *= require spree/frontend/solidus_hello_world\n", before: %r{\*/},
            verbose: true
        end

        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css',
          " *= require spree/backend/solidus_hello_world\n", before: %r{\*/},
          verbose: true
      end

      def add_migrations
        run 'bin/rails railties:install:migrations FROM=solidus_hello_world'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]')) # rubocop:disable Layout/LineLength
        if run_migrations
          run 'bin/rails db:migrate'
        else
          puts 'Skipping bin/rails db:migrate, don\'t forget to run it!' # rubocop:disable Rails/Output
        end
      end

      private

      def starter_frontend_available?
        defined?(SolidusStarterFrontend)
      end
    end
  end
end
