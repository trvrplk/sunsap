# -*- ruby -*-

require 'hoe'

Hoe.plugin :gemcutter
Hoe.plugin :roodi
Hoe.plugin :test
Hoe.plugin :bundler
Hoe.plugin :travis
Hoe.plugin :git
Hoe.plugins.delete :rubyforge

Hoe.spec 'sunsap' do
  developer('weddingcakes', 'keymint1498@gmail.com')
	license 'MIT'
  extra_deps << ['rspec',     "2.12.0"]
  extra_deps << ['mocha',     "0.13.1"]
  extra_deps << ['simplecov', "0.7.1" ]


  
  self.readme_file = "README.markdown"
  self.description = "Send messages to a reporter"
end

# vim: syntax=ruby
