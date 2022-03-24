# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

solidus_path = ENV.fetch('SOLIDUS_PATH', nil)
solidus_branch = ENV.fetch('SOLIDUS_BRANCH', 'master')
solidus_repo = ENV.fetch('SOLIDUS_REPO', 'solidusio/solidus')

gem 'solidus', solidus_path ? { path: solidus_path } : { github: solidus_repo, branch: solidus_branch }

gem 'solidus_frontend',
  github: 'gsmendoza/solidus',
  branch: 'gsmendoza/eng-304-update-commontest_app-to-apply-starter'

# Needed to help Bundler figure out how to resolve dependencies,
# otherwise it takes forever to resolve them.
# See https://github.com/bundler/bundler/issues/6677
gem 'rails', '>0.a'

# Provides basic authentication functionality for testing parts of your engine
gem 'solidus_auth_devise'

case ENV['DB']
when 'mysql'
  gem 'mysql2'
when 'postgresql'
  gem 'pg'
else
  gem 'sqlite3'
end

gemspec

# Use a local Gemfile to include development dependencies that might not be
# relevant for the project or for other contributors, e.g. pry-byebug.
#
# We use `send` instead of calling `eval_gemfile` to work around an issue with
# how Dependabot parses projects: https://github.com/dependabot/dependabot-core/issues/1658.
send(:eval_gemfile, 'Gemfile-local') if File.exist? 'Gemfile-local'
