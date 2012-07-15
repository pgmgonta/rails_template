#usage:
# rails new app_name -m template-path --skip-bundle
#

git :init

append_file '.gitignore', <<-END
.swap
vendor/bundle
END

gem 'i18n_generators', :group => :development
gem 'therubyracer'

testing =  yes?('Do you want testing gems?')
if testing 
  gem 'rspec-rails', :group => [:development, :test]
	gem 'cucumber-rails', :group => [:development, :test]
	gem 'webrat', :group => [:development, :test]
end

twitter_bootstrap =  yes?('Do you want twitter-bootstrap?')
if twitter_bootstrap
  gem 'twitter-bootstrap-rails', :group => [:development]
end

run 'bundle install --path vendor/bundle --without production --binstubs'

if testing 
	generate("rspec:install")
	create_file '.rspec', <<-END
--format specdoc
  END
end

if twitter_bootstrap
	generate("bootstrap:install")
end
