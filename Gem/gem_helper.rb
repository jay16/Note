learning website:
  http://railscasts.com/episodes/245-new-gem-with-bundler?autoplay=true
  http://gembundler.com/

commands:
		bundle gem lorem
		gem build lorem.gemspec
		gem push lorem-0.0.1.gem
		bundle
		rake -T
		rake build
		rake install
		rake release

create file:
		jay@jay-virtual-machine:~/ruby/MetaRuby/Gem$ bundle gem lorem
				    create  lorem/Gemfile
				    create  lorem/Rakefile
				    create  lorem/LICENSE
				    create  lorem/README.md
				    create  lorem/.gitignore
				    create  lorem/lorem.gemspec
				    create  lorem/lib/lorem.rb
				    create  lorem/lib/lorem/version.rb
		Initializating git repo in /home/jay/ruby/MetaRuby/Gem/lorem
		jay@jay-virtual-machine:~/ruby/MetaRuby/Gem$ cd lorem
		jay@jay-virtual-machine:~/ruby/MetaRuby/Gem/lorem$ gem build lorem.gemspec
				Successfully built RubyGem
				Name: lorem
				Version: 0.0.1
				File: lorem-0.0.1.gem
				
  



