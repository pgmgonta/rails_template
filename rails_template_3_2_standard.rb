#usage:
# rails new app_name -m template-path --skip-bundle
#

git :init

append_file '.gitignore', <<-END
.swap
/vendor/bundle
/bin
END

gem 'i18n_generators', :group => :development
gem 'therubyracer'

testing =  yes?('Do you want testing gems?')
if testing 
  gem 'rspec-rails', :group => [:development, :test]
  gem 'cucumber-rails', :group => [:test], :require => false
  gem 'capybara', :group => [:development, :test]
  gem 'database_cleaner', :group => [:development, :test]
  gem 'guard-spork', :group => [:development, :test]
  gem 'guard-rails', :group => [:development, :test]
  gem 'guard-cucumber', :group => [:development, :test]
  gem 'guard-rspec', :group => [:development, :test]
end

twitter_bootstrap =  yes?('Do you want twitter-bootstrap?')
if twitter_bootstrap
  gem 'twitter-bootstrap-rails', :group => [:development]
end

#--binstubs option 
#One time, run chmod +x $rvm_path/hooks/after_cd_bundler
run 'bundle install --path vendor/bundle --without production --binstubs'

if testing 
  generate("rspec:install")
  append_file '.rspec', <<-END
--format documentation
  END
  generate("cucumber:install --rspec --capybara")
end

if twitter_bootstrap
  generate("bootstrap:install")
end

git :add => '.', :commit => '-m "initial commit"'

if testing 
  puts "palease run 'spork --bootstrap'"
  puts "palease run 'guard init'"
end
