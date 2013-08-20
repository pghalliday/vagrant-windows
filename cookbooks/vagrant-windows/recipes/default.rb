include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby node[:vagrant_windows][:ruby_version]

rbenv_gem "bundler" do
  ruby_version node[:vagrant_windows][:ruby_version]
end
